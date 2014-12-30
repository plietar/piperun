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

require 'piperun/filters/coffeescript_filter'
require 'piperun/filters/copy_filter'
require 'piperun/filters/browserify_filter'
require 'piperun/filters/haml_filter'
require 'piperun/filters/jade_filter'
require 'piperun/filters/less_filter'
require 'piperun/filters/match_filter'
require 'piperun/filters/parallel_filter'
require 'piperun/filters/psd_filter'
require 'piperun/filters/sass_filter'
require 'piperun/filters/stylus_filter'
require 'piperun/filters/tar_filter'
require 'piperun/filters/typescript_filter'
require 'piperun/filters/gz_filter'
require 'piperun/filters/yui_css_filter'
require 'piperun/filters/yui_js_filter'

class Piperun::Pipeline::DSL
  add_filter :coffee,     Piperun::Filters::CoffeeScriptFilter
  add_filter :copy,       Piperun::Filters::CopyFilter
  add_filter :browserify, Piperun::Filters::BrowserifyFilter
  add_filter :haml,       Piperun::Filters::HamlFilter
  add_filter :jade,       Piperun::Filters::JadeFilter
  add_filter :less,       Piperun::Filters::LessFilter
  add_filter :match,      Piperun::Filters::MatchFilter
  add_filter :parallel,   Piperun::Filters::ParallelFilter
  add_filter :psd,        Piperun::Filters::PSDFilter
  add_filter :sass,       Piperun::Filters::SassFilter
  add_filter :scss,       Piperun::Filters::SassFilter
  add_filter :stylus,     Piperun::Filters::StylusFilter
  add_filter :tar,        Piperun::Filters::TarFilter
  add_filter :typescript, Piperun::Filters::TypeScriptFilter
  add_filter :gz,         Piperun::Filters::GzFilter
  add_filter :yui_css,    Piperun::Filters::YuiCssFilter
  add_filter :yui_js,     Piperun::Filters::YuiJsFilter
end
