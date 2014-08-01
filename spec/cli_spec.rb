require 'piperun/cli'

describe Piperun::CLI do
  attr_reader :project

  before do
    @project = Piperun::Project.new
    @project.stub(:run)
    @project.stub(:watch)
    Piperun::Project.stub(:new).and_return(@project)
    Piperun::Project.stub(:build).and_return(@project)
    Piperun::Project.stub(:load).and_return(@project)
  end

  def piperun(*args)
    Piperun::CLI.start args
  end

  context 'with no arguments' do
    it 'builds the project' do
      project.should_receive(:run)
      piperun
    end

    it 'doesn\'t watch the project' do
      project.should_not_receive(:watch)
      piperun
    end
  end

  context "with a watch argument" do
    it 'builds the project' do
      project.should_receive(:run)
      piperun "watch"
    end

    it 'watches the project' do
      project.should_receive(:watch)
      piperun "watch"
    end
  end
end

