require 'spec_helper'

describe "locations/new" do
  before(:each) do
    assign(:location, stub_model(Location,
      :latitude => 1.5,
      :longitude => 1.5,
      :accuracy => 1.5,
      :altitudeAccuracy => 1.5,
      :heading => 1.5,
      :speed => 1.5,
      :error_code => 1,
      :user => nil
    ).as_new_record)
  end

  it "renders new location form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", locations_path, "post" do
      assert_select "input#location_latitude[name=?]", "location[latitude]"
      assert_select "input#location_longitude[name=?]", "location[longitude]"
      assert_select "input#location_accuracy[name=?]", "location[accuracy]"
      assert_select "input#location_altitudeAccuracy[name=?]", "location[altitudeAccuracy]"
      assert_select "input#location_heading[name=?]", "location[heading]"
      assert_select "input#location_speed[name=?]", "location[speed]"
      assert_select "input#location_error_code[name=?]", "location[error_code]"
      assert_select "input#location_user[name=?]", "location[user]"
    end
  end
end
