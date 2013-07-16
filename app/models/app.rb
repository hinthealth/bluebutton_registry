class App
  include Mongoid::Document
  include Mongoid::Timestamps
  include DynamicAttributes::Schema

  field :url, type: String
  field :name, type: String
  field :approved, type: Boolean, default: false
  field :registration_jwt, type: String
  validates :name, :url, presence: true
  embeds_one :fixed_registration_parameters, class_name: "AppRegistration"

  accepts_nested_attributes_for :fixed_registration_parameters

  def self.generate_token(site, url, updated_at)
    jwk = JsonWebKey.current
    claim = {
      iss: site,
      sub: url,
      kid: jwk.kid,
      iat: updated_at
    }
    JSON::JWT.new(claim).sign(jwk.key, jwk.alg)
  end

  def generate_token!(site)
    self.registration_jwt = self.class.generate_token(site, self.url, self.updated_at)
    self.save
    return true
  rescue Exception => err
    puts "Unable to generate token: #{err} --------------- \n #{err.backtrace.join("\n")}\n ---------------"
  end

end
