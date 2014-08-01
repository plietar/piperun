module Piperun::Filters
  class GzFilter < TransformFilter
    add_extension '.gz'

    def transform(src, dst)
      Zlib::GzipWriter.open(dst) do |gz|
        gz.write IO.binread(src)
      end
    end

    def external_dependencies
      ['zlib']
    end
  end
end

