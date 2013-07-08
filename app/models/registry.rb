class Registry
  include Mongoid::Document
  include DynamicAttributes::Schema
  validates :name, :url, :jwks_uri, :trust_bundle_uri, :oauth2, presence: true
  field :name, type: String
  field :url, type: String
  field :jwks_uri, type: String
  field :trust_bundle_uri, type: String
  field :oauth2, type: Hash
  def self.for(host)
    Registry.where(url: host).first ||
    Registry.create({
      url: host,
      name: "BB+ Registry on Rails",
      url: 'http://' + host,
      trust_bundle_uri: nil,
      jwks_uri:  'http://' + host + "/public_key.jwks",
      oauth2: { introspect: nil }
    })
  end
end
