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


  def generate_token!(site)
    jwk = JsonWebKey.current
    claim = claim(site, jwk)
    self.registration_jwt = JSON::JWT.new(claim).sign(jwk.key, jwk.alg)
    self.save
    AppMailer.registered(self).deliver
    return true
  end
  def claim(site, jwk)
    {
      iss: site,
      sub: url,
      iat: updated_at,
      kid: jwk.kid
    }
  end

end
