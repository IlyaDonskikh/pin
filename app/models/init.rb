configure do
  REDIS = Redis.new(host: 'localhost', port: 6379, password: nil)
end
