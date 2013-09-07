require 'spec_helper'

describe "students/edit" do
  before(:each) do
    @student = assign(:student, stub_model(Student,
      :house => 1,
      :admin => false,
      :first_name => "MyString",
      :last_name => "MyString"
    ))
  end

  it "renders the edit student form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", student_path(@student), "post" do
      assert_select "input#student_house[name=?]", "student[house]"
      assert_select "input#student_admin[name=?]", "student[admin]"
      assert_select "input#student_first_name[name=?]", "student[first_name]"
      assert_select "input#student_last_name[name=?]", "student[last_name]"
    end
  end
end
