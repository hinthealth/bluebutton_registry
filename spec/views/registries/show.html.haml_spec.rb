require 'spec_helper'

describe "registries/show" do
  before(:each) do
    @registry = assign(:registry, stub_model(Registry,
      :name => "Name",
      :url => "Url",
      :jwks_uri => "Jwks Uri",
      :trust_bundle_uri => "Trust Bundle Uri",
      :oauth2 => ""
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    rendered.should match(/Url/)
    rendered.should match(/Jwks Uri/)
    rendered.should match(/Trust Bundle Uri/)
    rendered.should match(//)
  end
end
