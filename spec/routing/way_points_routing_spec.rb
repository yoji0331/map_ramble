require "spec_helper"

describe WayPointsController do
  describe "routing" do

    it "routes to #index" do
      get("/way_points").should route_to("way_points#index")
    end

    it "routes to #new" do
      get("/way_points/new").should route_to("way_points#new")
    end

    it "routes to #show" do
      get("/way_points/1").should route_to("way_points#show", :id => "1")
    end

    it "routes to #edit" do
      get("/way_points/1/edit").should route_to("way_points#edit", :id => "1")
    end

    it "routes to #create" do
      post("/way_points").should route_to("way_points#create")
    end

    it "routes to #update" do
      put("/way_points/1").should route_to("way_points#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/way_points/1").should route_to("way_points#destroy", :id => "1")
    end

  end
end
