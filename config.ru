require 'rubygems'
Gem.path << File.expand_path(File.join(File.dirname(__FILE__), 'gems'))
require 'sinatra'

Sinatra::Application.default_options.merge!(
  :run => false,
  :env => ENV['RACK_ENV']
)

require 'server'
run Sinatra.application

