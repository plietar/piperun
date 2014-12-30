module Piperun::Filters
  class StylusFilter < TransformFilter
    replace_extension '.css'

    def initialize(options = {})
      super()

      @options = options
    end

    def transform(src, dst)
      t = Stylus.compile(File.read(src), @options)
      File.write(dst, t)
    end

    def external_dependencies
      ['stylus']
    end
  end
end
