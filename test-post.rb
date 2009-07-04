#!/usr/bin/env ruby

require 'net/http'

if ARGV.grep(/\-h|\-\-help/).size > 0
  puts "Usage: test-post.rb [port]"
  exit 0
end

port = (ARGV[0] || 4567)

http = Net::HTTP.new("localhost", port)
response = http.request_post('/', 'payload={"foo": "bar"}')

puts response.read_body

