require 'spec_helper'

describe "way_points/edit" do
  before(:each) do
    @way_point = assign(:way_point, stub_model(WayPoint,
      :place => nil,
      :my_map => nil
    ))
  end

  it "renders the edit way_point form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", way_point_path(@way_point), "post" do
      assert_select "input#way_point_place[name=?]", "way_point[place]"
      assert_select "input#way_point_my_map[name=?]", "way_point[my_map]"
    end
  end
end
