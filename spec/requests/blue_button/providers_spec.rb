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
      end
      it "returns the json format in an array" do
        get api_blue_button_providers_path, format: :json
        response.body.should == [@provider].to_json
      end
    end
  end
end
