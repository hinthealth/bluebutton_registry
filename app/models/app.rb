class App
  include Mongoid::Document
  field :url, type: String
  field :name, type: String

  embeds_one :fixed_registration_parameters, class_name: "RegistrationParameters"
end
