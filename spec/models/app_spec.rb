require 'spec_helper'

describe App do
  describe '#to_json' do
    context "when loaded from the db" do
      before do
        @app = App.find(FactoryGirl.create(:blood_pressure_grapher).id)
      end
      subject{ JSON.parse(@app.to_json) }
      it "should include the fixed registration parameters by default" do
        subject['fixed_registration_parameters'].should_not be_empty
      end
    end
  end
end
