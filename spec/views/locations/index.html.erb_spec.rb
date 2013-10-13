require 'spec_helper'

describe "locations/index" do
  before(:each) do
    assign(:locations, [
      stub_model(Location,
        :latitude => 1.5,
        :longitude => 1.5,
        :accuracy => 1.5,
        :altitudeAccuracy => 1.5,
        :heading => 1.5,
        :speed => 1.5,
        :error_code => 1,
        :user => nil
      ),
      stub_model(Location,
        :latitude => 1.5,
        :longitude => 1.5,
        :accuracy => 1.5,
        :altitudeAccuracy => 1.5,
        :heading => 1.5,
        :speed => 1.5,
        :error_code => 1,
        :user => nil
      )
    ])
  end

  it "renders a list of locations" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.5.to_s, :count => 2
    assert_select "tr>td", :text => 1.5.to_s, :count => 2
    assert_select "tr>td", :text => 1.5.to_s, :count => 2
    assert_select "tr>td", :text => 1.5.to_s, :count => 2
    assert_select "tr>td", :text => 1.5.to_s, :count => 2
    assert_select "tr>td", :text => 1.5.to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
