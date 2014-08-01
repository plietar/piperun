module Piperun::Filters
  class TransformFilter < Filter
    def run(src, dst, files)
      outfiles = []
      files.each do |name|
        outname = mapping(name)
        next unless outname

        srcpath = File.join(src, name)
        dstpath = File.join(dst, outname)
        FileUtils::mkdir_p File.dirname(dstpath)

        transform(srcpath, dstpath)

        outfiles << outname
      end

      return outfiles
    end

    def mapping(name)
      name
    end

    #def transform(src, dst)
    #end

    protected
    def self.replace_extension ext
      self.class_eval <<-EVAL
      def mapping(name)
        "\#{File.join(File.dirname(name), File.basename(name, '.*'))}#{ext}"
      end
      EVAL
    end

    def self.add_extension ext
      self.class_eval <<-EVAL
      def mapping(name)
        "\#{name}#{ext}"
      end
      EVAL
    end
  end
end


