require 'spec_helper'

describe "initials/index" do
  before(:each) do
    assign(:initials, [
      stub_model(Initial,
        :lat => 1.5,
        :lng => 1.5,
        :zoom => 1
      ),
      stub_model(Initial,
        :lat => 1.5,
        :lng => 1.5,
        :zoom => 1
      )
    ])
  end

  it "renders a list of initials" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.5.to_s, :count => 2
    assert_select "tr>td", :text => 1.5.to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end
