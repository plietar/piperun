module Piperun::Filters
  class LessFilter < TransformFilter
    replace_extension '.css'

    def initialize(options = {})
      super()

      @options = options
    end

    def transform(src, dst)
      e = Less::Parser.new()
      t = e.parse(File.read(src))
      File.write(dst, t.to_css(@options))
    end

    def external_dependencies
      ['less']
    end
  end
end
