# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :provider_authentication do
    registration_uri "MyString"
    authorize_uri "MyString"
    token_uri "MyString"
    factory :good_health_clinic_authentication do
      registration_uri "http://portal.goodhealthclinic.org/register"
      authorize_uri "http://portal.goodhealthclinic.org/authorize"
      token_uri "http://portal.goodhealthclinic.org/token"
    end
  end
end
