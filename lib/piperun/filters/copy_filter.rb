module Piperun::Filters
  class CopyFilter < TransformFilter
    def transform(src, dst)
      FileUtils::copy_file src, dst
    end
  end
end

