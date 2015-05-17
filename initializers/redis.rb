require 'yaml'
config = YAML.load_file('./database.yml')
config = config[Sinatra::Base.environment.to_s]

REDIS = Redis.new(
  config: config['host'],
  port: config['port'],
  password: config['password'])
