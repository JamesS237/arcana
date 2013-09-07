require 'spec_helper'

describe "students/new" do
  before(:each) do
    assign(:student, stub_model(Student,
      :house => 1,
      :admin => false,
      :first_name => "MyString",
      :last_name => "MyString"
    ).as_new_record)
  end

  it "renders new student form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", students_path, "post" do
      assert_select "input#student_house[name=?]", "student[house]"
      assert_select "input#student_admin[name=?]", "student[admin]"
      assert_select "input#student_first_name[name=?]", "student[first_name]"
      assert_select "input#student_last_name[name=?]", "student[last_name]"
    end
  end
end
