class App
  include Mongoid::Document
  include DynamicAttributes::Schema
  field :url, type: String
  field :name, type: String
  validates :name, :url, presence: true
  embeds_one :fixed_registration_parameters, class_name: "AppRegistration"
  accepts_nested_attributes_for :fixed_registration_parameters
end
