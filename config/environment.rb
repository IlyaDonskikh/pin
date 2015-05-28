require 'rubygems'
require 'bundler'

Bundler.require(:default)
Bundler.require(Sinatra::Base.environment)

require './config/database'
require './config/locales'
require_all 'app/**/*.rb'
require_all 'initializers/*.rb'
require './app'

include CounterHelper
