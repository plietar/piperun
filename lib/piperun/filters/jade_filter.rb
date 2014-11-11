module Piperun::Filters
  class JadeFilter < TransformFilter
    replace_extension '.html'

    def initialize(options = {})
      super()

      @options = {
        options: {},
        debug: true,
        pretty: false
      }.merge options
    end

    def transform(src, dst)
      dstdir = File.dirname(dst)

      argv = ['jade', '--out', dstdir, '--obj', @options[:options].to_json]
      argv << '--no-debug'  if !@options[:debug]
      argv << '--pretty' if @options[:pretty]
      argv << src

      FileUtils::mkdir_p(File.dirname(dstdir))

      pid = Process.spawn(*argv)
      Process.wait(pid)
    end

    def external_dependencies
      ['json']
    end
  end
end
