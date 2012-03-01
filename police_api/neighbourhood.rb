module PoliceAPI
  class Neighbourhood
    attr_reader :id, :name, :force, :locations

    def initialize(options = {})
      @id, @name, @force = options[:id], options[:name], options[:force]
      @locations = load_locations
    end 

    def to_hash
      {
        :id => id,
        :name => name,
        :locations => locations
      }
    end

    private
      def load_locations
        ApiClient.neighbourhood( :force_id => force.id, :neighbourhood_id => id )['locations'].map do |location|
          location.merge!({ force_id: @force.id })
          
          unless Location.exists? location
            Location.create location
          end
        end
      rescue => e
        puts "Error: #{e}"
        return false
      end
  end
end