require 'spec_helper'

describe "way_points/show" do
  before(:each) do
    @way_point = assign(:way_point, stub_model(WayPoint,
      :place => nil,
      :my_map => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(//)
    rendered.should match(//)
  end
end
