module Piperun::Filters
  class TarFilter < Filter
    def initialize(output, options = {})
      super()

      @output = output
      @options = options
    end

    def run(src, dst, files)
      dstpath = File.join(dst, @output)
      FileUtils::mkdir_p File.dirname(dstpath)

      File.open(dstpath, 'wb') do |out|
        tar = Archive::Tar::Minitar::Output.new out
        Dir.chdir src do 
          files.each { |f| Archive::Tar::Minitar.pack_file(f, tar) }
        end
      end

      return [@output]
    end

    def external_dependencies
      ['archive/tar/minitar']
    end
  end
end

