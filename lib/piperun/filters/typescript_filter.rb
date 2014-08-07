module Piperun::Filters
  class TypeScriptFilter < Filter
    def initialize(options = {})
      super()
      @options = {
        output: nil,
        noImplicitAny: false
      }.merge(options)
    end

    def run(src, dst, files)
      argv = ["tsc"]
      argv << "--noImplicitAny" if @options[:noImplicitAny]

      unless @options[:output].nil?
        files.map! { |f| File.join(src, f) }
        dstpath = File.join(dst, @options[:output])

        FileUtils::mkdir_p File.dirname(dstpath)
        tsc *argv, "--out", dstpath, *files

        [@options[:output]]
      else
        outfiles = []

        files.each do |name|
          outname = "#{File.join(File.dirname(name), File.basename(name, '.*'))}.js"

          srcpath = File.join(src, name)
          dstpath = File.join(dst, outname)
          FileUtils::mkdir_p File.dirname(dstpath)

          tsc *argv, "--outDir", File.dirname(dstpath), srcpath

          outfiles << outname
        end

        outfiles
      end
    end

    private
    def tsc(*argv)
      pid = Process.spawn(*argv)
      Process.wait(pid)
      unless $?.exitstatus == 0
        raise StandardError, "Typescript Compiler failed"
      end
    end
  end
end

