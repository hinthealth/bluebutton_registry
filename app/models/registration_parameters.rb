class RegistrationParameters
  include Mongoid::Document
  embedded_in :app
  field :client_name, type: String
  field :client_uri, type: String
  field :logo_uri, type: String
  field :tos_uri, type: String
  field :redirect_uris, type: Array
  field :response_types, type: Array
  field :token_endpoint_auth_method, type: String
  field :grant_types, type: Array
  field :scope, type: String
  field :contacts, type: Array
end
