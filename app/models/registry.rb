class Registry
  include Mongoid::Document
  include DynamicAttributes::Schema
  validates :name, :url, :jwks_uri, :trust_bundle_uri, :oauth2, presence: true
  field :name, type: String
  field :url, type: String
  field :jwks_uri, type: String
  field :trust_bundle_uri, type: String
  field :oauth2, type: Hash

end
