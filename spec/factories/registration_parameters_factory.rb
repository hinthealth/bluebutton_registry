# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :registration_parameters, :class => 'RegistrationParameters' do
    factory :blood_pressure_grapher_registration_parameters do
      client_name "Blood Pressure Grapher"
      client_uri "https://bpgrapher.org"
      logo_uri "http://bpgrapher.org/images/logo.png"
      contacts ["plot-master@bpgrapher.org"]
      tos_uri "https://bpgrapher.org/tos"
      redirect_uris ["https://bpgrapher.org/after-auth"]
      response_types ["token"]
      grant_types ["implicit"]
      token_endpoint_auth_method "none"
      scope  "summary"
    end
  end
end
