require 'spec_helper'

describe JsonWebKey do
  describe "#key" do
    subject { JsonWebKey.current.key }
    it { should_not be_nil }
  end

  describe ".generate!" do
    subject { JsonWebKey.generate! }
    it { should_not be_nil }
    it { should be_persisted }
  end
  describe ".generate" do
    it { should_not be_nil }
    it { should_not be_persisted }
  end
  describe ".current" do
    before do
      JsonWebKey.count.should be_zero
    end
    subject { JsonWebKey.current }
    it { should_not be_nil }
    its(:kid){ should == 'default-key' }
    it { should be_persisted }
    describe "on the second call" do
      before do
        @first = JsonWebKey.current
        @second = JsonWebKey.current
      end
      it "should not generate a new key" do
        @first.should == @second
      end
    end
  end

  describe "validations" do
    it "should be valid from the factory" do
      FactoryGirl.build(:json_web_key).should be_valid
    end
    describe "unique kid" do
      before do
        @first = FactoryGirl.create(:json_web_key)
      end
      subject { FactoryGirl.build(:json_web_key, kid: @first.kid) }
      it { should_not be_valid }
    end
  end

end