require 'spec_helper'

describe "results/new" do
  before(:each) do
    assign(:result, stub_model(Result,
      :student_id => 1,
      :assessment_id => 1,
      :mark => "9.99"
    ).as_new_record)
  end

  it "renders new result form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", results_path, "post" do
      assert_select "input#result_student_id[name=?]", "result[student_id]"
      assert_select "input#result_assessment_id[name=?]", "result[assessment_id]"
      assert_select "input#result_mark[name=?]", "result[mark]"
    end
  end
end
