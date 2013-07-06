require 'spec_helper'
def canonicalize_json(json)
  JSON.parse(json).to_json
end
describe Registry do
  describe "saving performance" do
    require 'benchmark'
    # Should create 100 registries in under a second
    it "should build a registry in less than a second" do
      Benchmark.realtime{
        FactoryGirl.create_list(:registry, 1)
      }.should < 1
    end

    it "should not take forever to validate" do
      @registries = FactoryGirl.build_list(:registry, 2)
      Benchmark.realtime{
        @registries.each{|r| r.valid? }
      }.should < 1
    end
  end
  describe "valid_attributes_json=" do
    before do
      @registry = FactoryGirl.build(:registry)
    end
    subject { @registry }
    context "with valid schema.org json" do
      before do
        @dynamic_attributes_json = <<-JSON
        {
          "location": {
            "geo": {
              "latitude": 42.3591,
              "longitude": -71.0934
            }
          }
        }
        JSON
        @registry.dynamic_attributes_json = @dynamic_attributes_json
      end
      it { should be_valid }
      its(:dynamic_attributes_json) { should == canonicalize_json(@dynamic_attributes_json) }
      describe "on save" do
        before do
          @registry.save
          @registry.reload
        end
        its(:dynamic_attributes_json) { should == canonicalize_json(@dynamic_attributes_json) }
        it "should have stored any keys as attributes" do
          @registry['location'].should == {'geo' => {'latitude' => 42.3591, 'longitude' => -71.0934}}
        end
      end
    end
    pending "with invalid schema.org json" do
      before do
        @dynamic_attributes_json = <<-JSON
        {
          "phone_number": {
            "office": {
              "cell": "415-555-1234"
            }
          }
        }
        JSON
        @registry.dynamic_attributes_json= @dynamic_attributes_json
      end
      it { should_not be_valid }
      its(:dynamic_attributes_json) { should == canonicalize_json(@dynamic_attributes_json) }
      describe "on save" do
        before do
          @registry.save.should_be_false
          @registry.reload
        end
        its(:dynamic_attributes_json) { should == nil }
      end
    end
  end
end
