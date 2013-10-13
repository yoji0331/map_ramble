require 'spec_helper'

describe "place_images/new" do
  before(:each) do
    assign(:place_image, stub_model(PlaceImage,
      :place => nil,
      :data => "",
      :content_type => "MyString"
    ).as_new_record)
  end

  it "renders new place_image form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", place_images_path, "post" do
      assert_select "input#place_image_place[name=?]", "place_image[place]"
      assert_select "input#place_image_data[name=?]", "place_image[data]"
      assert_select "input#place_image_content_type[name=?]", "place_image[content_type]"
    end
  end
end
