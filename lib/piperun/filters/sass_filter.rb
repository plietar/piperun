module Piperun::Filters
  class SassFilter < TransformFilter
    replace_extension '.css'

    def initialize(options = {})
      super()

      @options = options
    end

    def transform(src, dst)
      e = Sass::Engine.for_file src, @options
      File.write dst, e.render
    end

    def external_dependencies
      ['sass']
    end
  end
end

