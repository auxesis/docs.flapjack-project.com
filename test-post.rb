#!/usr/bin/env ruby

require 'net/http'

http = Net::HTTP.new("localhost", 4567)
response = http.request_post('/', 'payload={"foo": "bar"}')

puts response.read_body

