require 'spec_helper'

describe "checkins/edit" do
  before(:each) do
    @checkin = assign(:checkin, stub_model(Checkin,
      :user => nil,
      :place => nil
    ))
  end

  it "renders the edit checkin form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", checkin_path(@checkin), "post" do
      assert_select "input#checkin_user[name=?]", "checkin[user]"
      assert_select "input#checkin_place[name=?]", "checkin[place]"
    end
  end
end
