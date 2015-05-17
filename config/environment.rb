require 'rubygems'
require 'bundler'

Bundler.require(:default)
Bundler.require(Sinatra::Base.environment)

Dir[File.join('./app/', '**/*.rb')].each do |file|
  require file
end

require './config/redis'
require './app'