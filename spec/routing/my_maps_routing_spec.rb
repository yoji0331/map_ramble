require "spec_helper"

describe MyMapsController do
  describe "routing" do

    it "routes to #index" do
      get("/my_maps").should route_to("my_maps#index")
    end

    it "routes to #new" do
      get("/my_maps/new").should route_to("my_maps#new")
    end

    it "routes to #show" do
      get("/my_maps/1").should route_to("my_maps#show", :id => "1")
    end

    it "routes to #edit" do
      get("/my_maps/1/edit").should route_to("my_maps#edit", :id => "1")
    end

    it "routes to #create" do
      post("/my_maps").should route_to("my_maps#create")
    end

    it "routes to #update" do
      put("/my_maps/1").should route_to("my_maps#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/my_maps/1").should route_to("my_maps#destroy", :id => "1")
    end

  end
end
