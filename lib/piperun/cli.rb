require 'piperun'
require 'methadone'

module Piperun
  class CLI
    include Methadone::Main
    include Methadone::CLILogging

    description "Process files with pipelines"
    version Piperun::VERSION

    on "-V", "--verbose", "Run verbosely"
    on "--watch", ""

    main do
      if options[:verbose]
        Piperun::logger.level = Logger::DEBUG
      else
        Piperun::logger.level = Logger::INFO
      end

      network = Piperun::Network.load "Pipeline.rb"

      unless options[:watch]
        network.run
      else
        network.watch
      end
    end
  end
end

