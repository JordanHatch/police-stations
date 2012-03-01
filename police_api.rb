require 'active_support/core_ext/hash'
require 'active_support/core_ext/array'
require 'open-uri'
require 'json'
require 'logger'
require 'geocoder'
require 'mongoid'

require_relative 'police_api/api_client'
require_relative 'police_api/force'
require_relative 'police_api/geocoder'
require_relative 'police_api/location'
require_relative 'police_api/neighbourhood'

if File.exists?('config/api_key.rb') 
  require_relative 'config/api_key' 
else
  raise Exception.new("Could not find config/api_key.rb. Add your credentials to config/api_key.example.rb and rename the file.")
end

Mongoid.load!("./config/mongoid.yml")