module Piperun::Filters
  class Filter
    #def run(src, dst, files)
    #end

    def initialize
      super

      require_dependencies!
    end
    
    protected
    def external_dependencies
      return []
    end

    private
    def require_dependencies!
      external_dependencies.each do |d|
        begin
          require d
        rescue LoadError => error
          raise error, "#{self.class} requires #{d}, but it is not available"
        end
      end
    end
  end
end

require 'piperun/filters/transform_filter'

require 'piperun/filters/copy_filter'
require 'piperun/filters/browserify_filter'
require 'piperun/filters/match_filter'
require 'piperun/filters/parallel_filter'
require 'piperun/filters/sass_filter'
require 'piperun/filters/tar_filter'
require 'piperun/filters/gz_filter'
require 'piperun/filters/yui_css_filter'
require 'piperun/filters/yui_js_filter'

class Piperun::Pipeline::DSL
  add_filter :copy,       Piperun::Filters::CopyFilter
  add_filter :browserify, Piperun::Filters::BrowserifyFilter
  add_filter :match,      Piperun::Filters::MatchFilter
  add_filter :parallel,   Piperun::Filters::ParallelFilter
  add_filter :sass,       Piperun::Filters::SassFilter
  add_filter :scss,       Piperun::Filters::SassFilter
  add_filter :tar,        Piperun::Filters::TarFilter
  add_filter :gz,         Piperun::Filters::GzFilter
  add_filter :yui_css,    Piperun::Filters::YuiCssFilter
  add_filter :yui_js,     Piperun::Filters::YuiJsFilter
end

