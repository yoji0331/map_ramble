require 'spec_helper'

describe "place_images/show" do
  before(:each) do
    @place_image = assign(:place_image, stub_model(PlaceImage,
      :place => nil,
      :data => "",
      :content_type => "Content Type"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(//)
    rendered.should match(//)
    rendered.should match(/Content Type/)
  end
end
