require "spec_helper"

describe Api::RegistriesController do
  describe "routing" do

    it "routes to #index" do
      get("/api/registries").should route_to("api/registries#index")
    end

    it "routes to #new" do
      get("/api/registries/new").should route_to("api/registries#new")
    end

    it "routes to #show" do
      get("/api/registries/1").should route_to("api/registries#show", :id => "1")
    end

    it "routes to #edit" do
      get("/api/registries/1/edit").should route_to("api/registries#edit", :id => "1")
    end

    it "routes to #create" do
      post("/api/registries").should route_to("api/registries#create")
    end

    it "routes to #update" do
      put("/api/registries/1").should route_to("api/registries#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/api/registries/1").should route_to("api/registries#destroy", :id => "1")
    end

  end
end
