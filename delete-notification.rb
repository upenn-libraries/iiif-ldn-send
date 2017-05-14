#!/usr/bin/env ruby

require 'rest-client'
require 'json'
require 'yaml'

def load_config
  config = YAML.load_file('config.yml')
  @notifications_url = config['config']['notifications_url']
end

load_config

# RestClient.post "http://example.com/resource", {'x' => 1}.to_json, {content_type: :json, accept: :json}
notification_id = ARGV.shift || ''

raise "Please provide an ID" if notification_id.strip.empty?

url = "#{@notifications_url.chomp '/'}/#{notification_id}"
puts "Deleting: #{url}"
response = RestClient.delete url, { accept: :json }

puts "response code is: #{response.code}"
puts "response body is: #{response.body}"