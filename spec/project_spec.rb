require 'piperun'

describe Piperun::Project do
  let(:project) { Piperun::Project.new }
  let(:pipelines) do
    [
      Piperun::Pipeline.new(tmpdir + 'p1/in', tmpdir + 'p1/out'),
      Piperun::Pipeline.new(tmpdir + 'p2/in', tmpdir + 'p2/out'),
      Piperun::Pipeline.new(tmpdir + 'p3/in', tmpdir + 'p3/out')
    ]
  end

  before do
    pipelines.each do |p|
      project.add_pipeline p
      p.stub(:run)
      p.stub(:watch)
    end
  end

  describe '#run' do
    it 'runs each pipeline' do
      pipelines.each do |p|
        expect(p).to receive(:run)
      end
      project.run
    end

    it 'doesn\'t watch the pipelines' do
      pipelines.each do |p|
        expect(p).to_not receive(:watch)
      end
      project.run
    end
  end

  describe '#watch' do
    it 'doesn\'t run the pipelines' do
      pipelines.each do |p|
        expect(p).to_not receive(:run)
      end
      project.watch
    end

    it 'watches each pipelines' do
      pipelines.each do |p|
        expect(p).to receive(:watch)
      end
      project.watch
    end
  end
end

