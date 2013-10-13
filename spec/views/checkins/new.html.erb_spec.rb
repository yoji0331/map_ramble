require 'spec_helper'

describe "checkins/new" do
  before(:each) do
    assign(:checkin, stub_model(Checkin,
      :user => nil,
      :place => nil
    ).as_new_record)
  end

  it "renders new checkin form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", checkins_path, "post" do
      assert_select "input#checkin_user[name=?]", "checkin[user]"
      assert_select "input#checkin_place[name=?]", "checkin[place]"
    end
  end
end
