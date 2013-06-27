# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :registry do
    name "MyString"
    url "MyString"
    jwks_uri "MyString"
    trust_bundle_uri "MyString"
    oauth2 ""
  end
end
