require 'spec_helper'

describe "students/show" do
  before(:each) do
    @student = assign(:student, stub_model(Student,
      :house => 1,
      :admin => false,
      :first_name => "First Name",
      :last_name => "Last Name"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    rendered.should match(/false/)
    rendered.should match(/First Name/)
    rendered.should match(/Last Name/)
  end
end
