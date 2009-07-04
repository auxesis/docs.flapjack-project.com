#!/usr/bin/env ruby

require 'net/http'

if ARGV.grep(/\-h|\-\-help/).size > 0
  puts "Usage: test-post.rb [host] [port]"
  exit 0
end

host = (ARGV[0] || 'localhost')
port = (ARGV[1] || 4567)

http = Net::HTTP.new(host, port)
response = http.request_post('/', 'payload={"foo": "bar"}')

puts response.read_body

