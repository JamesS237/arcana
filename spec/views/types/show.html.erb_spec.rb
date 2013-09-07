require 'spec_helper'

describe "types/show" do
  before(:each) do
    @type = assign(:type, stub_model(Type,
      :name => "Name",
      :weight => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    rendered.should match(/1/)
  end
end
