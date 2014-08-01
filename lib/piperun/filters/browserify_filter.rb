module Piperun::Filters
  class BrowserifyFilter < Filter
    def initialize(entry, options = {})
      super()

      @entry = [*entry]
      @options = {
        output: 'bundle.js',
        debug: false,
        fast: false
      }.merge options
    end

    def run(src, dst, files)
      entry = @entry.map { |e| File.join(src, e) }
      dstpath = File.join(dst, @options[:output])
      FileUtils::mkdir_p File.dirname(dstpath)

      argv = ['browserify',
              '-o', dstpath,
              *entry]
      argv += ['--debug'] if @options[:debug]
      argv += ['--fast'] if @options[:fast]

      pid = Process.spawn(*argv)
      Process.wait(pid)

      return [@options[:output]]
    end
  end
end

