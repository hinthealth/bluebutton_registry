# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :app do
    url "MyString"
    name "MyString"
    fixed_registration_parameters {FactoryGirl.build(:registration_parameters)}
    factory :blood_pressure_grapher do
      url "https://bpgrapher.org"
      name "Blood Pressure Grapher"
      fixed_registration_parameters { FactoryGirl.build(:blood_pressure_grapher_registration_parameters) }
    end
  end
end
