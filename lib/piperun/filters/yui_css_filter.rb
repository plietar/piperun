module Piperun::Filters
  class YuiCssFilter < TransformFilter
    def initialize(options = {})
      super()

      @options = options
    end

    def transform(src, dst)
      c = YUI::CssCompressor.new @options
      File.write dst, c.compress(File.read src)
    end

    def external_dependencies
      ['yui/compressor']
    end
  end
end


