if ENV['COVERAGE'] || ENV['CI']
  require 'simplecov'
  SimpleCov.start do
    add_filter '/spec/'
  end
end

begin
  require 'pry'
rescue LoadError # rubocop:disable Lint/HandleExceptions
end

require 'haml_lint'

Dir['spec/support/**/*.rb'].each { |file| require file.sub('spec/', '') }

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.disable_monkey_patching!
  config.example_status_persistence_file_path = 'spec/examples.txt'
  config.filter_run_when_matching :focus
  config.shared_context_metadata_behavior = :apply_to_host_groups
  config.warnings = true

  config.default_formatter = 'doc' if config.files_to_run.one?
  config.profile_examples = 10 if ENV['PROFILE']

  config.order = :random
  Kernel.srand config.seed
end
