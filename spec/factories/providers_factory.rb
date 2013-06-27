# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :provider do
    name "MyString"
    url "MyString"
    patient_signin "MyString"
    oauth2 { FactoryGirl.build(:provider_authentication) }
    bb_api { FactoryGirl.build(:provider_blue_button_api) }
    factory :good_health_clinic do
      name "Good Health Clinic"
      description "Serving your health needs since 1999"
      url "http://goodhealthclinic.org"
      patient_signin "http://portal.goodhealthclinic.org"
      oauth2 { FactoryGirl.build(:good_health_clinic_authentication) }
      bb_api { FactoryGirl.build(:good_health_clinic_blue_button_api) }
    end
  end
end