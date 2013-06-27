class ProviderBlueButtonApi
  include Mongoid::Document
  embedded_in :provider

  field :summary, type: String
  field :search, type: String
end
