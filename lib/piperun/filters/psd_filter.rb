module Piperun::Filters
  class PSDFilter < TransformFilter
    replace_extension '.png'

    def initialize(options = {})
      super()

      @options = options
    end

    def transform(src, dst)
      e = PSD.new(src)
      File.write(dst, e.image.to_png)
    end

    def external_dependencies
      ['psd']
    end
  end
end
