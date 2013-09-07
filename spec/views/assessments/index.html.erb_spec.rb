require 'spec_helper'

describe "assessments/index" do
  before(:each) do
    assign(:assessments, [
      stub_model(Assessment,
        :subject_id => 1,
        :type_id => "Type",
        :title => "Title",
        :exam => false
      ),
      stub_model(Assessment,
        :subject_id => 1,
        :type_id => "Type",
        :title => "Title",
        :exam => false
      )
    ])
  end

  it "renders a list of assessments" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "Type".to_s, :count => 2
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
  end
end
