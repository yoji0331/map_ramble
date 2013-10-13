require 'spec_helper'

describe "my_maps/new" do
  before(:each) do
    assign(:my_map, stub_model(MyMap,
      :user => nil
    ).as_new_record)
  end

  it "renders new my_map form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", my_maps_path, "post" do
      assert_select "input#my_map_user[name=?]", "my_map[user]"
    end
  end
end
