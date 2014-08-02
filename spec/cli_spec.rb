require 'piperun/cli'

describe Piperun::CLI do
  let(:project) { Piperun::Project.new }

  before do
    project.stub(:run)
    project.stub(:watch)
    Piperun::Project.stub(:new).and_return(project)
    Piperun::Project.stub(:build).and_return(project)
    Piperun::Project.stub(:load).and_return(project)

    Kernel.stub :sleep
  end

  def piperun(*args)
    Piperun::CLI.start args
  end

  context 'with no arguments' do
    it 'builds the project' do
      expect(project).to receive(:run)
      piperun
    end

    it 'doesn\'t watch the project' do
      expect(project).to_not receive(:watch)
      piperun
    end
  end

  context "with a watch argument" do
    it 'builds the project' do
      expect(project).to receive(:run)
      piperun "watch"
    end

    it 'watches the project' do
      expect(project).to receive(:watch)
      piperun "watch"
    end

    it 'sleeps forever' do
      expect(Kernel).to receive(:sleep)
      piperun "watch"
    end
  end
end

