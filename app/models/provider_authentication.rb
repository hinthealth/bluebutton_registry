class ProviderAuthentication
  include Mongoid::Document
  embedded_in :provider

  field :registration_uri, type: String
  field :authorize_uri, type: String
  field :token_uri, type: String
  field :introspect_uri, type: String
end
