require 'spec_helper'

describe "initials/show" do
  before(:each) do
    @initial = assign(:initial, stub_model(Initial,
      :lat => 1.5,
      :lng => 1.5,
      :zoom => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1.5/)
    rendered.should match(/1.5/)
    rendered.should match(/1/)
  end
end
