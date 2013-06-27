# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :registry do
    name "The BB+ Registry Foundation"
    url "http://registry.org/"
    jwks_uri "https://registry.org/public_key.jwks"
    trust_bundle_uri "MyString"
    oauth2 {{"introspect" => "https://registry.org/oauth/introspect"}}
  end
end
