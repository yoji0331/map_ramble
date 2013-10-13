require "spec_helper"

describe PlaceImagesController do
  describe "routing" do

    it "routes to #index" do
      get("/place_images").should route_to("place_images#index")
    end

    it "routes to #new" do
      get("/place_images/new").should route_to("place_images#new")
    end

    it "routes to #show" do
      get("/place_images/1").should route_to("place_images#show", :id => "1")
    end

    it "routes to #edit" do
      get("/place_images/1/edit").should route_to("place_images#edit", :id => "1")
    end

    it "routes to #create" do
      post("/place_images").should route_to("place_images#create")
    end

    it "routes to #update" do
      put("/place_images/1").should route_to("place_images#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/place_images/1").should route_to("place_images#destroy", :id => "1")
    end

  end
end
