#!/usr/bin/env ruby

require 'rest-client'
require 'json'

# RestClient.post "http://example.com/resource", {'x' => 1}.to_json, {content_type: :json, accept: :json}
json_file = ARGV.shift

raise "Can't find JSON file: #{json_file}" unless File.exists? json_file
data = open(json_file).read

response = RestClient.post "http://sims-dev.library.upenn.edu:8084/iiif/notifications", data, { content_type: :json, accept: :json }

puts "response code is: #{response.code}"
puts "response body is: #{response.body}"