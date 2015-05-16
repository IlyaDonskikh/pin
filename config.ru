require 'rubygems'
require 'bundler'
Bundler.require

Dir.glob('./{models,services}/*.rb').each do |file|
  require file
end

require './app'
run SinatraTest::Application

