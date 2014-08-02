require 'piperun/version'

describe 'Piperun::VERSION' do
  it 'is a string' do
    expect(Piperun::VERSION).to be_a(String)
  end

  it 'looks like a version' do
    expect(Piperun::VERSION).to match(/^\d+\.\d+(\.\d+)?$/)
  end
end

