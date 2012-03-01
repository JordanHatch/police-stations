require 'rake'
require 'bundler'

require_relative 'police_api'

desc "Import all police forces from the API to the database"
task :import do
  @forces = PoliceAPI::Force.all
  @threads = []

  @forces.in_groups(4).each_with_index do |group, i|
    @threads << Thread.new {
      puts "..."
      group.each do |f|
        f.to_hash rescue {}
      end
    }
  end

  @threads.each { |thread| thread.join }
end