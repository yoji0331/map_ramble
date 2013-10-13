require 'spec_helper'

describe "my_maps/show" do
  before(:each) do
    @my_map = assign(:my_map, stub_model(MyMap,
      :user => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(//)
  end
end
