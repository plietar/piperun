module Piperun::Filters
  class HamlFilter < TransformFilter
    replace_extension '.html'

    def initialize(options = {})
      super()

      @options = options
    end

    def transform(src, dst)
      e = Haml::Engine.new(File.read(src), @options)
      File.write(dst, e.render)
    end

    def external_dependencies
      ['haml']
    end
  end
end
