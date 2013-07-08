require 'spec_helper'

describe "Providers" do
  describe "GET /api/blue_button/providers" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get api_blue_button_providers_path, format: :json
      response.status.should be(200)
    end

    context "with a sample provider" do
      before do
        @provider = FactoryGirl.create(:good_health_clinic)
        get api_blue_button_providers_path, format: :json
      end
      describe "should return an array with that registry" do
        subject { JSON.parse(response.body) }
        its(:length){ should == 1 }
      end
      describe "the provider JSON" do
        subject { JSON.parse(response.body)[0] }
        it { subject['name'].should == "Good Health Clinic" }
        it { subject['description'].should == "Serving your health needs since 1999"}
        it { subject['url'].should == "http://goodhealthclinic.org" }
        it { subject['patient_signin'].should == "http://portal.goodhealthclinic.org" }
        it { subject['oauth2'].should == {"authorize_uri"=>"http://portal.goodhealthclinic.org/authorize", "registration_uri"=>"http://portal.goodhealthclinic.org/register", "token_uri"=>"http://portal.goodhealthclinic.org/token", "introspect_uri" => nil}  }
        it { subject['bb_api'].should == {"search"=>"http://api.goodhealthclinic.org/patient/documents/search", "summary"=>"http://api.goodhealthclinic.org/patient/documents/summary"} }
        its(:keys){ should_not include('_id') }

        its(:keys){ should include('@context') }

        context "@context object" do
          before do
            json_ld_context = <<-JSON
            {
              "@context": {
                "@vocab": "http://schema.org/",
                "oauth2": "http://siframework.org/ABBI/oauth2_endpoints",
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

            @provider_boilerplate_context = JSON.parse(json_ld_context)
          end
          subject{ JSON.parse(response.body)[0]['@context'] }
          it{ should == @provider_boilerplate_context['@context'] }
        end
      end
    end
  end
end
