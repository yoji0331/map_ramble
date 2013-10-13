require 'spec_helper'

describe "my_maps/edit" do
  before(:each) do
    @my_map = assign(:my_map, stub_model(MyMap,
      :user => nil
    ))
  end

  it "renders the edit my_map form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", my_map_path(@my_map), "post" do
      assert_select "input#my_map_user[name=?]", "my_map[user]"
    end
  end
end
