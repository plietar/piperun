module Piperun
  class Project
    attr_reader :pipelines

    def initialize
      @pipelines = []
    end

    def add_pipeline(p)
      @pipelines << p
    end

    def self.build(&block)
      pipe = new
      dsl = DSL.new(pipe)
      dsl.instance_eval(&block)
      pipe
    end

    def self.load(filename)
      pipe = new
      dsl = DSL.new(pipe)
      dsl.instance_eval(File.read(filename), filename)
      pipe
    end

    class DSL
      def initialize(parent)
        @parent = parent
      end

      def pipeline(src, dst, &block)
        @parent.add_pipeline Pipeline.build(src, dst, &block)
      end
    end

    def run
      @pipelines.each do |p|
        p.run
      end
    end

    def watch
      @pipelines.each do |p|
        p.watch
      end
    end
  end
end

