require 'spec_helper'

describe "types/edit" do
  before(:each) do
    @type = assign(:type, stub_model(Type,
      :name => "MyString",
      :weight => 1
    ))
  end

  it "renders the edit type form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", type_path(@type), "post" do
      assert_select "input#type_name[name=?]", "type[name]"
      assert_select "input#type_weight[name=?]", "type[weight]"
    end
  end
end
