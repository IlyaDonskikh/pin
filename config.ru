require 'rubygems'
require 'bundler'
Bundler.require

Dir[File.join('./app/', '**/*.rb')].each do |file|
  require file
end

require './app'
run WheelyPin::Application
