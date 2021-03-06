ENV['RACK_ENV'] ||= 'test'

require './config/environment'

REDIS.flushdb

def app
  @app ||= WheelyPin::Application
end

RSpec.configure do |config|
  config.include Rack::Test::Methods
end
