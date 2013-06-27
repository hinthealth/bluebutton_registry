require 'spec_helper'

describe "Registries" do
  describe "GET /api/blue_button/apps" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get api_blue_button_apps_path, format: :json
      response.status.should be(200)
    end

    context "with a sample app" do
      before do
        @app = FactoryGirl.create(:blood_pressure_grapher)
      end
      it "returns the json format in an array" do
        get api_blue_button_apps_path, format: :json
        response.body.should == [@app].to_json
      end
    end
  end
end
