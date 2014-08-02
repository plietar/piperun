RSpec.configure do |config|
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.run_all_when_everything_filtered = true
  config.filter_run :focus

  def tmpdir
    @tmpdir ||= Pathname.new(Dir.mktmpdir)
  end

  config.after(:each) do
    @tmpdir.rmtree if @tmpdir
    @tmpdir = nil
  end
end

