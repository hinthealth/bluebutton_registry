# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :provider_blue_button_api do
    summary "MyString"
    search "MyString"
    factory :good_health_clinic_blue_button_api do
      summary "http://api.goodhealthclinic.org/patient/documents/summary"
      search "http://api.goodhealthclinic.org/patient/documents/search"
    end
  end
end
