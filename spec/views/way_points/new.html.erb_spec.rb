require 'spec_helper'

describe "way_points/new" do
  before(:each) do
    assign(:way_point, stub_model(WayPoint,
      :place => nil,
      :my_map => nil
    ).as_new_record)
  end

  it "renders new way_point form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", way_points_path, "post" do
      assert_select "input#way_point_place[name=?]", "way_point[place]"
      assert_select "input#way_point_my_map[name=?]", "way_point[my_map]"
    end
  end
end
