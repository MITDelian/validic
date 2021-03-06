require 'validic'
require 'vcr'
require 'simplecov'
require 'simplecov-rcov'
require 'api_matchers'

class SimpleCov::Formatter::MergedFormatter
  def format(result)
    SimpleCov::Formatter::HTMLFormatter.new.format(result)
    SimpleCov::Formatter::RcovFormatter.new.format(result)
  end
end

SimpleCov.formatter = SimpleCov::Formatter::MergedFormatter
SimpleCov.start do
  add_filter '/vendor'
end

VCR.configure do |c|
  c.allow_http_connections_when_no_cassette = true
  c.cassette_library_dir = 'spec/cassette'
  c.hook_into :webmock
  c.configure_rspec_metadata!
  c.default_cassette_options = { record: :new_episodes }
end

RSpec.configure do |c|
  c.include APIMatchers::RSpecMatchers

  c.treat_symbols_as_metadata_keys_with_true_values = true

  ##
  # Add gem specific configuration for easy access
  #
  c.before(:each) do
    Validic.configure do |config|
      # config.api_url        = 'https://api.validic.com'
      config.api_url        = 'http://api.validic.dev' #development config
      config.api_version    = 'v1'
      config.access_token   = '9c03ad2bcb022425944e4686d398ef8398f537c2f7c113495ffa7bc9cfa49286'
    end
  end
end
