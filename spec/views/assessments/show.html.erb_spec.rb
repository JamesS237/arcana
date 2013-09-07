require 'spec_helper'

describe "assessments/show" do
  before(:each) do
    @assessment = assign(:assessment, stub_model(Assessment,
      :subject_id => 1,
      :type_id => "Type",
      :title => "Title",
      :exam => false
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    rendered.should match(/Type/)
    rendered.should match(/Title/)
    rendered.should match(/false/)
  end
end
