require 'rubygems'
require 'bundler'
Bundler.require

Dir[File.join('./app/', '**/*.rb')].each do |file|
  require file
end

require_relative 'redis'
require './app'