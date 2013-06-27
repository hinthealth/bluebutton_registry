require 'spec_helper'

describe "registries/index" do
  before(:each) do
    assign(:registries, [
      stub_model(Registry,
        :name => "Name",
        :url => "Url",
        :jwks_uri => "Jwks Uri",
        :trust_bundle_uri => "Trust Bundle Uri",
        :oauth2 => ""
      ),
      stub_model(Registry,
        :name => "Name",
        :url => "Url",
        :jwks_uri => "Jwks Uri",
        :trust_bundle_uri => "Trust Bundle Uri",
        :oauth2 => ""
      )
    ])
  end

  it "renders a list of registries" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Url".to_s, :count => 2
    assert_select "tr>td", :text => "Jwks Uri".to_s, :count => 2
    assert_select "tr>td", :text => "Trust Bundle Uri".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
  end
end
