require 'piperun'
require 'thor'

module Piperun
  class CLI < Thor
    #description "Process files with pipelines"
    #version Piperun::VERSION

    default_task :build

    desc "build", "Build the project."
    def build
      filename = File.exist?("Pipefile") ? "Pipefile" : "Pipefile.rb"

      project = Piperun::Project.load filename
      project.run
    end

    desc "watch", "Watch the project"
    def watch
      filename = File.exist?("Pipefile") ? "Pipefile" : "Pipefile.rb"

      project = Piperun::Project.load filename
      project.run
      project.watch

      begin
        Kernel.sleep
      rescue Interrupt
      end
    end
  end
end

