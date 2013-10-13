require 'spec_helper'

describe "place_images/index" do
  before(:each) do
    assign(:place_images, [
      stub_model(PlaceImage,
        :place => nil,
        :data => "",
        :content_type => "Content Type"
      ),
      stub_model(PlaceImage,
        :place => nil,
        :data => "",
        :content_type => "Content Type"
      )
    ])
  end

  it "renders a list of place_images" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "Content Type".to_s, :count => 2
  end
end
