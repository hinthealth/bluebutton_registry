require 'spec_helper'

describe "Registries" do
  describe "GET /api/blue_button/registries" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get api_blue_button_registries_path, format: :json
      response.status.should be(200)
    end

    context "with a sample registry" do
      before do
        default_attributes = {
          name: "The BB+ Registry Foundation",
          url: "http://registry.org/",
          jwks_uri: "https://registry.org/public_key.jwks",
          oauth2: {
            introspect: "https://registry.org/oauth/introspect"
          }
        }
        @registry = FactoryGirl.create(:registry, default_attributes)
      end
      it "returns the json format in an array" do
        get api_blue_button_registries_path, format: :json
        response.body.should == [@registry].to_json
      end
    end
  end
end
