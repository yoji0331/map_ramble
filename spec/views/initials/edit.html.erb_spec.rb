require 'spec_helper'

describe "initials/edit" do
  before(:each) do
    @initial = assign(:initial, stub_model(Initial,
      :lat => 1.5,
      :lng => 1.5,
      :zoom => 1
    ))
  end

  it "renders the edit initial form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", initial_path(@initial), "post" do
      assert_select "input#initial_lat[name=?]", "initial[lat]"
      assert_select "input#initial_lng[name=?]", "initial[lng]"
      assert_select "input#initial_zoom[name=?]", "initial[zoom]"
    end
  end
end
