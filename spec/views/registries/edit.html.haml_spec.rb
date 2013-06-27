require 'spec_helper'

describe "registries/edit" do
  before(:each) do
    @registry = assign(:registry, stub_model(Registry,
      :name => "MyString",
      :url => "MyString",
      :jwks_uri => "MyString",
      :trust_bundle_uri => "MyString",
      :oauth2 => ""
    ))
  end

  it "renders the edit registry form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", registry_path(@registry), "post" do
      assert_select "input#registry_name[name=?]", "registry[name]"
      assert_select "input#registry_url[name=?]", "registry[url]"
      assert_select "input#registry_jwks_uri[name=?]", "registry[jwks_uri]"
      assert_select "input#registry_trust_bundle_uri[name=?]", "registry[trust_bundle_uri]"
      assert_select "input#registry_oauth2[name=?]", "registry[oauth2]"
    end
  end
end
