class Provider
  include Mongoid::Document
  field :name, type: String
  field :url, type: String
  field :patient_signin, type: String
  field :description, type: String
  embeds_one :oauth2, class_name: 'ProviderAuthentication'
  accepts_nested_attributes_for :oauth2
  embeds_one :bb_api, class_name: 'ProviderBlueButtonApi'
  accepts_nested_attributes_for :bb_api
end
