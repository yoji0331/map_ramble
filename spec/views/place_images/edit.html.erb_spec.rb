require 'spec_helper'

describe "place_images/edit" do
  before(:each) do
    @place_image = assign(:place_image, stub_model(PlaceImage,
      :place => nil,
      :data => "",
      :content_type => "MyString"
    ))
  end

  it "renders the edit place_image form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", place_image_path(@place_image), "post" do
      assert_select "input#place_image_place[name=?]", "place_image[place]"
      assert_select "input#place_image_data[name=?]", "place_image[data]"
      assert_select "input#place_image_content_type[name=?]", "place_image[content_type]"
    end
  end
end
