class JsonWebKey
  include Mongoid::Document
  include Mongoid::Timestamps

  field :kty, type: String # Key Type, e.g. RSA
  # field :use, type String # Key Use, identifies the intended use of the key
  # # e.g. "sig" (signature or MAC operation), or "enc" (encryption)
  field :n, type: String # Modulus - for RSA type keys
  field :e, type: String # Exponent - for RSA type keys
  field :alg, type: String # Algorithm, eg HS256/RS256
  field :kid, type: String # 'production-key'

  def self.current
    order('created_at').last
  end


  def self.generate()

  end
end