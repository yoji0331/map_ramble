require 'spec_helper'

describe "way_points/index" do
  before(:each) do
    assign(:way_points, [
      stub_model(WayPoint,
        :place => nil,
        :my_map => nil
      ),
      stub_model(WayPoint,
        :place => nil,
        :my_map => nil
      )
    ])
  end

  it "renders a list of way_points" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
