module PoliceAPI
  class Location
    include Mongoid::Document
    include Geocoder::Model::Mongoid

    geocoded_by :address_from_components
    after_validation :geocode  

    validates_uniqueness_of :name, :coordinates, { :allow_blank => :true }
    validates_uniqueness_of :address
    validates_presence_of :address

    before_validation :strip_rubbish_on_title

    field :name, type: String
    field :address, type: String
    field :postcode, type: String
    field :description, type: String
    field :coordinates, type: Array
    field :force_id, type: String
    
    def self.exists?(location)
      self.where(postcode: location['postcode']).count > 0 
    end

    def has_coordinates?
      coordinates.present? and !coordinates[0].blank? and !coordinates[1].blank?
    end

    private
      def strip_rubbish_on_title
        name.gsub!(/,?/, '')
        name.gsub!(/\n/, ', ')
      end

      def address_from_components
        [name, address, postcode].compact.join(", ")
      end
  end
end