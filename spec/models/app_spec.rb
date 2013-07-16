require 'spec_helper'

describe App do
  describe ".generate_token" do
    before do
      @site = 'http://bluebuttonregistry.example.com/'
      @url = 'http://joshuamandel.com/blue-button-blood-pressure-app'
      @updated_at = Time.now
    end
    subject { App.generate_token(@site, @url, @updated_at) }
    it { should_not be_empty }
  end
  describe "#generate_token" do
    before do
      @app = FactoryGirl.create(:blood_pressure_grapher)
      @app.generate_token!(@site).should be_true
    end
    subject { @app }
    its(:registration_jwt) { should_not be_empty }
  end
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
