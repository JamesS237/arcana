require 'spec_helper'

describe "students/index" do
  before(:each) do
    assign(:students, [
      stub_model(Student,
        :house => 1,
        :admin => false,
        :first_name => "First Name",
        :last_name => "Last Name"
      ),
      stub_model(Student,
        :house => 1,
        :admin => false,
        :first_name => "First Name",
        :last_name => "Last Name"
      )
    ])
  end

  it "renders a list of students" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => "First Name".to_s, :count => 2
    assert_select "tr>td", :text => "Last Name".to_s, :count => 2
  end
end
