module Piperun::Filters
  class CoffeeScriptFilter < TransformFilter
    replace_extension '.js'

    def initialize(options = {})
      super()

      @options = options
    end

    def transform(src, dst)
      t = CoffeeScript.compile(File.read(src))
      File.write(dst, t)
    end

    def external_dependencies
      ['coffee-script']
    end
  end
end
