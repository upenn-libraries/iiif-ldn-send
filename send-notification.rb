#!/usr/bin/env ruby

require 'rest-client'
require 'json'
require 'yaml'
require 'i18n'


def load_config
  config = YAML.load_file('config.yml')
  @notifications_url = config['config']['notifications_url']
  @language_code = config['config']['language_code']
end

load_config

I18n.load_path = Dir["locales/#{@language_code}.yml"]
I18n.backend.load_translations

# RestClient.post "http://example.com/resource", {'x' => 1}.to_json, {content_type: :json, accept: :json}
json_file = ARGV.shift

raise I18n.t('errors.argument_missing') if json_file.nil?
raise I18n.t('errors.file_not_found', :json_file => json_file) unless File.exists? json_file
data = open(json_file).read

response = RestClient.post @notifications_url, data, { content_type: :json, accept: :json }

puts I18n.t('response.code', :response_code => response.code)
puts I18n.t('response.body', :response_body => response.body)