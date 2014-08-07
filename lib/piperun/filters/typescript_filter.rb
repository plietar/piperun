module Piperun::Filters
  class TypeScriptFilter < TransformFilter
    replace_extension '.js'

    def transform(src, dst)
      unless system("tsc #{src} --out #{dst}")
        raise StandardError, "Typescript Compiler failed"
      end
    end
  end
end

