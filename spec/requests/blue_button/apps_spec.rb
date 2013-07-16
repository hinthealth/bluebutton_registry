require 'spec_helper'

describe "Apps" do
  describe "GET /api/blue_button/apps" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get api_blue_button_apps_path, format: :json
      response.status.should be(200)
    end

    context "with a sample app" do
      before do
        @app = FactoryGirl.create(:blood_pressure_grapher)
        get api_blue_button_apps_path, format: :json
      end
      describe "should return an array with that registry" do
        subject { JSON.parse(response.body) }
        its(:length){ should == 1 }
      end
      describe "the provider JSON" do
        subject { JSON.parse(response.body)[0] }
        it { subject['name'].should == "Blood Pressure Grapher" }
        it { subject['url'].should == "https://bpgrapher.org" }
        its(:keys){ should_not include('_id') }
        its(:keys){ should_not include('registration_jwt') }
        its(:keys){ should include('@context') }
        its(:keys){ should include('fixed_registration_parameters') }
      end
      describe "fixed registration parameters" do
        subject { JSON.parse(response.body)[0]['fixed_registration_parameters'] }
        it { subject['client_name'].should == 'Blood Pressure Grapher' }
        it { subject['client_uri'].should == 'https://bpgrapher.org' }
        it { subject['contacts'].should == ['plot-master@bpgrapher.org'] }
        it { subject['grant_types'].should == ['implicit'] }
        it { subject['logo_uri'].should == 'http://bpgrapher.org/images/logo.png' }
        it { subject['redirect_uris'].should == ['https://bpgrapher.org/after-auth'] }
        it { subject['response_types'].should == ['token'] }
        it { subject['scope'].should == 'summary' }
        it { subject['token_endpoint_auth_method'].should == 'none' }
        it { subject['tos_uri'].should == 'https://bpgrapher.org/tos' }
      end
      context "@context object" do
        before do
          json_ld_context = <<-JSON
          {
            "@context": {
              "@vocab": "http://schema.org/",
              "oauth2": "http://siframework.org/ABBI/oauth2_endpoints",
              "jwks_uri": "http://siframework.org/ABBI/jwks_uri",
              "trust_bundle_uri": "http://siframework.org/ABBI/trust_bundle_uri",
              "bb_api": "http://siframework.org/ABBI/bbplus_data_endpoints",
              "authorize": "http://siframework.org/ABBI/endpoint/authorize",
              "token": "http://siframework.org/ABBI/endpoint/token",
              "summary": "http://siframework.org/ABBI/endpoint/summary",
              "search": "http://siframework.org/ABBI/endpoint/search",
              "client_name": "http://tools.ietf.org/html/draft-ietf-oauth-dyn-reg#client_name",
              "client_uri": "http://tools.ietf.org/html/draft-ietf-oauth-dyn-reg#client_uri",
              "logo_uri": "http://tools.ietf.org/html/draft-ietf-oauth-dyn-reg#logo_uri",
              "tos_uri": "http://tools.ietf.org/html/draft-ietf-oauth-dyn-reg#tos_uri",
              "redirect_uris": "http://tools.ietf.org/html/draft-ietf-oauth-dyn-reg#redirect_uris",
              "response_type": "http://tools.ietf.org/html/draft-ietf-oauth-dyn-reg#response_type",
              "token_endpoint_auth_method": "http://tools.ietf.org/html/draft-ietf-oauth-dyn-reg#tokoen_endpoint_auth_method",
              "grant_types": "http://tools.ietf.org/html/draft-ietf-oauth-dyn-reg#grant_types",
              "scope": "http://tools.ietf.org/html/draft-ietf-oauth-dyn-reg#scope",
              "contacts": "http://tools.ietf.org/html/draft-ietf-oauth-dyn-reg#contacts"
            }
          }
          JSON

          @app_boilerplate_context = JSON.parse(json_ld_context)
        end
        subject { JSON.parse(response.body)[0]['@context'] }
        it { should == @app_boilerplate_context['@context'] }
      end
    end
  end
end
