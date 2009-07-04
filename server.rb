#!/usr/bin/env ruby
require 'rubygems'
Gem.path << File.expand_path(File.join(File.dirname(__FILE__), 'gems'))
require 'sinatra'
require 'run_later'
require 'yajl/json_gem'

WEBSITE_DIR = "/home/auxesis/code/flapjack-project.com"
CHECKOUT_DIR = "/home/auxesis/code/flapjack"

get '/' do 
  "POST to this URL to generate docs!"
end

post '/' do
  push = JSON.parse(params[:payload] || '')
  run_later do
    create_or_update_repo
    build_site
  end
  "Generating docs..."
end

def create_or_update_repo
  if File.exists?(CHECKOUT_DIR)
    system("cd #{CHECKOUT_DIR}; git pull")
  else
    system("cd #{File.join(CHECKOUT_DIR, '..')} ; git clone git://github.com/auxesis/flapjack.git #{CHECKOUT_DIR}")
  end
end

def build_site
  system("cd #{WEBSITE_DIR}; rake build ")
  system("cd #{WEBSITE_DIR}; rake local_deploy")
end
