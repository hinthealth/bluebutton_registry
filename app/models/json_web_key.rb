class JsonWebKey
  include Mongoid::Document
  include Mongoid::Timestamps
  validates :kid, uniqueness: true

  field :kty, type: String, default: 'RSA' # Key Type, e.g. RSA
  # field :use, type String # Key Use, identifies the intended use of the key
  # # e.g. "sig" (signature or MAC operation), or "enc" (encryption)
  field :alg, type: String, default: 'RS256' # Algorithm, eg HS256/RS256
  field :kid, type: String # 'production-key'

  # For RSA type keys
  field :n, type: String # Modulus
  field :e, type: String # Public exponent
  field :d, type: String # Private exponent
  field :p, type: String # Prime 1
  field :q, type: String # Prime 2
  field :dmp1, type: String # d mod (p-1)
  field :dmq1, type: String # d mod (q-1)
  field :iqmp, type: String # (inverse of q) mod p

  RSA_PRIVATE_KEYS = [:n, :e, :d, :p, :q, :dmp1, :dmq1, :iqmp]
  RSA_PUBLIC_KEYS = [:n, :e]

  def self.current
    last || generate!
  end

  def self.generate!(kid = 'default-key')
    generate(kid).tap do |k|
      k.save!
    end
  end

  def self.generate(kid = 'default-key')
    key = OpenSSL::PKey::RSA.generate(512)
    new(kid: kid, key: key)
  end

  def key
    if !defined?(@key) || @key.blank?
      @key = load_key
    end
  end

  def key=(new_key)
    store_key(@key = new_key)
  end

  protected
  def store_key(key)
    key.tap do |key|
      RSA_PRIVATE_KEYS.each do |atr|
        self[atr] = key.send(atr).to_s # Big integers, store as strings
      end
    end
  end

  def load_key
    OpenSSL::PKey::RSA.new.tap do |key|
      RSA_PRIVATE_KEYS.each do |atr|
        key.send("#{atr}=", self[atr].to_i)
      end
    end
  end
end