require 'rails_helper'

RSpec.describe "assignment_sets/new", type: :view do
  before(:each) do
    assign(:assignment_set, AssignmentSet.new())
  end

  it "renders new assignment_set form" do
    render

    assert_select "form[action=?][method=?]", assignment_sets_path, "post" do
    end
  end
end
