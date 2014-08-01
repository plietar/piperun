module Piperun::Filters
  class MatchFilter < CopyFilter
    def initialize(*args)
      super()

      @patterns = [*args]
    end

    def mapping(name)
      name if @patterns.any? { |p| File.fnmatch(p, name) }
    end
  end
end

