require 'spec_helper'

describe "Registry" do
  describe "GET /api/blue_button/registry" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get api_blue_button_registry_path, format: :json
      response.status.should be(200)
    end

    context "with a sample registry" do
      before do
        get api_blue_button_registry_path, format: :json
      end

      describe "should return a single registry object" do
        subject { JSON.parse(response.body) }
        it { subject.should be_is_a(Hash) }
      end
      describe "the registry JSON" do
        subject { JSON.parse(response.body) }
        it { subject['name'].should == "BB+ Registry on Rails" }
        it { subject['url'].should == "http://www.example.com" }
        it { subject['jwks_uri'].should == "http://www.example.com/generated/public_jwks.json" }
        it { subject['oauth2'].should == {"introspect" => nil} }
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

            @registry_boilerplate_context = JSON.parse(json_ld_context)
          end
          subject{ JSON.parse(response.body)['@context'] }
          it{ should == @registry_boilerplate_context['@context'] }
        end
      end
    end
  end
end
