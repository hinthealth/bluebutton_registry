require "spec_helper"

describe Api::BlueButton::RegistriesController do
  describe "routing" do

    it "routes to #show" do
      get("/api/blue_button/registry").should route_to("api/blue_button/registries#show")
    end
    it "routes from the canonical API location" do
      get("/.well-known/bb/registry").should route_to("api/blue_button/registries#show")
    end
  end
end
