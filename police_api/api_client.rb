module PoliceAPI
  class ApiClient
    API_URL = "http://policeapi2.rkh.co.uk/api/"

    class << self; 
      attr_accessor :credentials
    end

    class MissingParameter < Exception; end

    def self.forces
      self.load_json ['forces']
    end

    def self.neighbourhoods( options = { } )
      raise MissingParameter.new("force_id") unless options[:force_id]
      self.load_json [ options[:force_id], 'neighbourhoods' ]
    end

    def self.neighbourhood( options = { } )
      raise MissingParameter.new("force_id") unless options[:force_id]
      raise MissingParameter.new("neighbourhood_id") unless options[:neighbourhood_id]

      self.load_json [ options[:force_id], options[:neighbourhood_id] ]
    end

    def self.load_json(path)
      url = URI.escape(API_URL + path.join('/'))
      logger.debug "Fetching from #{url}"

      JSON.load( open( url, { :http_basic_authentication => self.credentials } ))
    end

    private
      def self.logger
        @logger ||= Logger.new(STDOUT)
      end
  end
end