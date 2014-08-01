module Piperun::Filters
  class ParallelFilter < Filter
    attr_reader :pipelines

    def initialize(&block)
      super()

      @pipelines = []

      dsl = DSL.new(self)
      dsl.instance_eval(&block)
    end

    def add_pipeline(p)
      @pipelines << p
    end

    def run(src, dst, files)
      outfiles = []
      @pipelines.each do |p|
        outfiles |= Piperun::Pipeline.build(src, dst, &p).run(files)
      end
      return outfiles
    end

    class DSL
      def initialize(parent)
        @parent = parent
      end

      def run(&block)
        @parent.add_pipeline(block)
      end
    end
  end
end

