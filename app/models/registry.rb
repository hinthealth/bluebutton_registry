class Registry
  include Mongoid::Document
  validate :valid_additional_attributes
  validates :name, :url, :jwks_uri, :trust_bundle_uri, :oauth2, presence: true
  before_save :store_additional_attributes
  field :name, type: String
  field :url, type: String
  field :jwks_uri, type: String
  field :trust_bundle_uri, type: String
  field :oauth2, type: Hash
  def additional_attributes_json=(new_additional_attributes_json)
    parse_additional_attributes_json(new_additional_attributes_json)
  end
  def additional_attributes_json
    retrieve_additional_attributes_json
  end

  protected
  # Handle schema attributes json
  def parse_additional_attributes_json(new_additional_attributes_json)
    self.dynamic_attributes = JSON.parse(new_additional_attributes_json)
  end

  def retrieve_additional_attributes_json
    self.dynamic_attributes.to_json
  end

  def self.validate_schema(data)
    [] # TODO
  end

  def valid_additional_attributes
    errors = self.class.validate_schema(self.dynamic_attributes)
    self.errors.add(:additional_attributes_json, errors) if errors.any?
  end


  # Handle dynamic attributes

  def dynamic_attributes=(new_dynamic_attributes)
    @new_dynamic_attributes = new_dynamic_attributes
  end

  def dynamic_attributes
    @new_dynamic_attributes || (@dynamic_attributes ||= attributes.slice(*dynamic_attribute_names))
  end

  def dynamic_attribute_names
    attributes.keys - attribute_names
  end

  def store_additional_attributes
    if @new_dynamic_attributes
      @new_dynamic_attributes.each do |k,v|
        write_attribute(k, v)
      end
      @new_dynamic_attributes = @dynamic_attributes = nil
    end
  end


end
