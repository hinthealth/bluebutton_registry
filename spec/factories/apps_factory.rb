# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :app do
    url "MyString"
    name "MyString"
    fixed_registration_parameters {FactoryGirl.build(:app_registration)}
    factory :blood_pressure_grapher do
      url "https://bpgrapher.org"
      name "Blood Pressure Grapher"
      fixed_registration_parameters { FactoryGirl.build(:blood_pressure_grapher_registration) }
    end
  end
end
