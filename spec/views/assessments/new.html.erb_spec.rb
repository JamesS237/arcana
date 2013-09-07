require 'spec_helper'

describe "assessments/new" do
  before(:each) do
    assign(:assessment, stub_model(Assessment,
      :subject_id => 1,
      :type_id => "MyString",
      :title => "MyString",
      :exam => false
    ).as_new_record)
  end

  it "renders new assessment form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", assessments_path, "post" do
      assert_select "input#assessment_subject_id[name=?]", "assessment[subject_id]"
      assert_select "input#assessment_type_id[name=?]", "assessment[type_id]"
      assert_select "input#assessment_title[name=?]", "assessment[title]"
      assert_select "input#assessment_exam[name=?]", "assessment[exam]"
    end
  end
end
