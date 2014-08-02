require 'piperun'
require 'pp'

describe Piperun::Pipeline do
  class MockFilter
    def run(src, dst, files)
      files
    end
  end

  let(:input) { tmpdir + 'in' }
  let(:output) { tmpdir + 'out' }
  let(:pipeline) { Piperun::Pipeline.new(input, output) }
  let(:filters) do
    [
      MockFilter.new,
      MockFilter.new,
      MockFilter.new
    ]
  end

  before do
    filters.each do |f|
      pipeline.add_filter f
    end

    Dir.mkdir(input)
  end

  describe '#run' do
    context 'with a file list' do
      it 'creates temporary directories for filters' do
        filters.each do |f|
          expect(f).to receive(:run) do |src, dst, files|
            expect(File.directory?(src)).to be true
            expect(File.directory?(dst)).to be true

            files
          end
        end

        pipeline.run ['foo', 'bar']
      end

      it 'deletes all temporary directories' do
        dirs = []
        filters.each do |f|
          expect(f).to receive(:run) do |src, dst, files|
            dirs << src unless(dirs.include? src or src == input.to_s or src == output.to_s)
            dirs << dst unless(dirs.include? dst or dst == input.to_s or dst == output.to_s)
          end
        end

        pipeline.run ['foo', 'bar']

        dirs.each do |d|
          expect(File.directory?(d)).to be false
        end
      end

      it 'doesn\'t delete source and destination directories' do
        pipeline.run ['foo', 'bar']

        expect(File.directory?(input)).to be true
        expect(File.directory?(output)).to be true
      end

      it 'chains the file list' do
        files = [
          ['foo', 'bar'],
          ['hello', 'world'],
          ['foobar'],
          ['blabla']
        ]
        infiles = files[0]

        filters.each do |f|
          expect(f).to receive(:run).with(anything(), anything(), match_array(files[0])).and_return(files[1])
          files.shift
        end

        outfiles = pipeline.run infiles
        expect(outfiles).to match_array(files[0])
      end
    end

    context 'without a file list' do
      it 'uses all files in the source directory' do
        files = ['foo', 'bar/foo']

        files.each do |f|
          FileUtils.mkdir_p(File.dirname(input + f))
          FileUtils.touch(input + f)
        end

        filters.each do |f|
          expect(f).to receive(:run).with(anything(), anything(), match_array(files)).and_return(files)
        end

        pipeline.run
      end
    end
  end

  describe '#watch' do
    it 'watches the input directory' do
      watcher = double()
      expect(Listen).to receive(:to).with(input.to_s).and_return(watcher)
      expect(watcher).to receive(:start).and_return(true)

      pipeline.watch
    end

    context 'when a file is modified' do
      it 'runs the pipeline' do
        watcher = double()
        block = nil

        expect(Listen).to receive(:to) do |path, &b|
          block = b
          watcher
        end

        expect(watcher).to receive(:start) do
          expect(block).to_not be_nil
          block.call
        end

        expect(pipeline).to receive(:run)

        pipeline.watch
      end
    end
  end
end

