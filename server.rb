#!/usr/bin/env ruby

require 'rubygems'
Gem.clear_paths
Gem.path << File.expand_path(File.join(File.dirname(__FILE__), 'gems'))

require 'sinatra'
require 'run_later'
require 'yajl/json_gem'

WEBSITE_SOURCE_DIR = "/home/auxesis/code/flapjack-project.com"
FLAPJACK_CHECKOUT_DIR = "/home/auxesis/code/flapjack"

get '/' do 
  "POST to this URL to generate docs!"
end

post '/' do
  push = JSON.parse(params[:payload] || '')
  run_later do
    create_or_update_website_repo
    create_or_update_flapjack_repo
    build_site
  end
  "Generating docs..."
end

def create_or_update_website_repo
  if File.exists?(WEBSITE_SOURCE_DIR)
    system("cd #{WEBSITE_SOURCE_DIR}; git pull")
  else
    system("cd #{File.join(WEBSITE_SOURCE_DIR, '..')} ; git clone git://github.com/auxesis/flapjack-project.com.git #{WEBSITE_SOURCE_DIR}")
  end
end

def create_or_update_flapjack_repo
  if File.exists?(FLAPJACK_CHECKOUT_DIR)
    system("cd #{FLAPJACK_CHECKOUT_DIR}; git pull")
  else
    system("cd #{File.join(FLAPJACK_CHECKOUT_DIR, '..')} ; git clone git://github.com/auxesis/flapjack.git #{FLAPJACK_CHECKOUT_DIR}")
  end
end

def build_site
  system("cd #{WEBSITE_SOURCE_DIR}; rake build ")
  system("cd #{WEBSITE_SOURCE_DIR}; rake local_deploy")
end
