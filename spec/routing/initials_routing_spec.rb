require "spec_helper"

describe InitialsController do
  describe "routing" do

    it "routes to #index" do
      get("/initials").should route_to("initials#index")
    end

    it "routes to #new" do
      get("/initials/new").should route_to("initials#new")
    end

    it "routes to #show" do
      get("/initials/1").should route_to("initials#show", :id => "1")
    end

    it "routes to #edit" do
      get("/initials/1/edit").should route_to("initials#edit", :id => "1")
    end

    it "routes to #create" do
      post("/initials").should route_to("initials#create")
    end

    it "routes to #update" do
      put("/initials/1").should route_to("initials#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/initials/1").should route_to("initials#destroy", :id => "1")
    end

  end
end
