require 'csv'
require 'sinatra'

require_relative 'police_api'

set :public_folder, File.dirname(__FILE__) + '/static'

get '/locations' do
  @locations = PoliceAPI::Location.order_by([[:force_id, :asc],[:name, :asc]]).all

  erb :locations
end

get '/locations.csv' do
  @locations = PoliceAPI::Location.all

  content_type :csv
  CSV.generate do |csv|
    csv << ["name", "address1", "address2", "town", "postcode", "access_notes", "general_notes", "url", "source_address"]
    @locations.each do |location|
      csv << [location.name, location.address, "", "", location.postcode, "", "", "", ""]
    end
  end
end