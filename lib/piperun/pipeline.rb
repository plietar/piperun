require 'tmpdir'
require 'listen'

module Piperun
  class Pipeline
    attr_reader :filters
    def initialize(src, dst)
      @src = File.absolute_path(src)
      @dst = File.absolute_path(dst)
      @filters = []
    end

    def add_filter(f)
      @filters << f
    end

    def self.build(src, dst, &block)
      pipe = new(src, dst)
      dsl = DSL.new(pipe)
      dsl.instance_eval(&block)
      pipe
    end

    class DSL
      def initialize(parent)
        @parent = parent
      end

      def filter(f)
        @parent.add_filter(f)
      end

      def self.add_filter(name, f)
        self.class_eval <<-EVAL
        def #{name}(*args, &block)
          self.filter #{f}.new *args, &block
        end
        EVAL
      end
    end

    def run(files = nil)
      if files == nil
        Dir.chdir @src do
          files = Dir['**/*'].reject {|fn| File.directory?(fn) }
        end
      end

      src = @src

      @filters.each do |f|
        begin
          break if files.length == 0

          if f == @filters.last
            dst = @dst
          else
            dst = Dir.mktmpdir
          end

          files = f.run(src, dst, files)
        ensure
          FileUtils.remove_entry_secure src unless src == @src
        end

        src = dst
      end

      return files
    end

    def watch
      Listen.to(@src) do |modified, added, removed|
        run
      end.start
    end
  end
end  

