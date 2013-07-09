class App
  include Mongoid::Document
  include Mongoid::Timestamps
  include DynamicAttributes::Schema

  field :url, type: String
  field :name, type: String
  field :approved, type: Boolean, default: false
  validates :name, :url, presence: true
  embeds_one :fixed_registration_parameters, class_name: "AppRegistration"
  embeds_one :registration_response
  accepts_nested_attributes_for :fixed_registration_parameters

end
