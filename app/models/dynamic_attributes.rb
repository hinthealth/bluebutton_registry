module DynamicAttributes
  module Schema
    extend ActiveSupport::Concern
    included do
      validate :valid_dynamic_attributes
      before_save :store_dynamic_attributes
    end
    module ClassMethods
      def validate_schema(data)
        [] # TODO
      end
    end
    def dynamic_attributes_json=(new_dynamic_attributes_json)
      parse_dynamic_attributes_json(new_dynamic_attributes_json)
    end
    def dynamic_attributes_json
      retrieve_dynamic_attributes_json
    end

    protected
    # Handle schema attributes json
    def parse_dynamic_attributes_json(new_dynamic_attributes_json)
      self.dynamic_attributes = JSON.parse(new_dynamic_attributes_json)
    end

    def retrieve_dynamic_attributes_json
      self.dynamic_attributes.to_json
    end

    def valid_dynamic_attributes
      errors = self.class.validate_schema(self.dynamic_attributes)
      self.errors.add(:dynamic_attributes_json, errors) if errors.any?
    end

    # Handle store/retrieval of dynamic attributes

    def dynamic_attributes=(new_dynamic_attributes)
      @new_dynamic_attributes = new_dynamic_attributes
    end

    def dynamic_attributes
      @new_dynamic_attributes || (@dynamic_attributes ||= attributes.slice(*dynamic_attribute_names))
    end

    def dynamic_attribute_names
      attributes.keys - attribute_names
    end

    def store_dynamic_attributes
      if @new_dynamic_attributes
        @new_dynamic_attributes.each do |k,v|
          write_attribute(k, v)
        end
        @new_dynamic_attributes = @dynamic_attributes = nil
      end
    end
  end
end
