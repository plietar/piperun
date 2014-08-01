require 'piperun/cli'

describe Piperun::CLI do
  attr_reader :network

  before do
    @network = Piperun::Network.new
    @network.stub(:run)
    @network.stub(:watch)
    Piperun::Network.stub(:new).and_return(@network)
    Piperun::Network.stub(:build).and_return(@network)
    Piperun::Network.stub(:load).and_return(@network)
  end

  def piperun(*args)
    args.unshift("piperun")
    ::ARGV.replace args
    Piperun::CLI.go!
  rescue SystemExit
  end

  context 'with no arguments' do
    it 'runs the network' do
      network.should_receive(:run)
      piperun
    end

    it 'doesn\'t watch the network' do
      network.should_not_receive(:watch)
      piperun
    end
  end

  context "with a --watch argument" do
    it 'watches the network' do
      network.should_receive(:watch)
      piperun "--watch"
    end
  end
end

