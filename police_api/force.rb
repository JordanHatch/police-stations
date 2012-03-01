module PoliceAPI
  class Force
    attr_reader :id, :name

    def initialize(options = {})
      @id = options[:id]
      @name = options[:name]
    end

    def neighbourhoods
      @neighbourhoods ||= load_neighbourhoods
    end

    def to_hash
      { 
        :id => self.id,
        :name => self.name,
        :neighbourhoods => self.neighbourhoods.map {|n| n.to_hash}
      }
    end

    def self.all
      logger.info "Loading all forces"
      ApiClient.forces.map do |hash|
        Force.new :id => hash['id'], :name => hash['name']
      end
    end

    private
      def load_neighbourhoods
        ApiClient.neighbourhoods(:force_id => self.id).map do |neighbourhood|
          Neighbourhood.new :id => neighbourhood['id'], :name => neighbourhood['name'], :force => self
        end
      end

      def self.logger
        @logger ||= Logger.new(STDOUT)
      end
  end
end