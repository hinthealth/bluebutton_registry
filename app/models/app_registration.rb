class AppRegistration
  include Mongoid::Document
  embedded_in :app
  field :client_name, type: String
  field :client_uri, type: String
  field :logo_uri, type: String
  field :tos_uri, type: String
  field :redirect_uris, type: Array, default: []
  field :response_types, type: Array, default: []
  field :token_endpoint_auth_method, type: String
  field :grant_types, type: Array, default: []
  field :scope, type: String
  field :contacts, type: Array, default: []

  [:redirect_uris, :response_types, :contacts, :grant_types].each do |attribute|
    define_method("#{attribute}_string") do
      send(attribute).join("\n")
    end
    define_method("#{attribute}_string=") do |new_attribute|
      # Splits on (optional) whitespace and commas
      send("#{attribute}=", new_attribute.split(/\s*\n\s*/) )
    end
  end
end
