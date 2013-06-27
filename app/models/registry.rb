class Registry
  include Mongoid::Document
  field :name, type: String
  field :url, type: String
  field :jwks_uri, type: String
  field :trust_bundle_uri, type: String
  field :oauth2, type: Hash
end
