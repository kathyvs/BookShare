require 'rails_helper'

RSpec.describe "assignment_sets/edit", type: :view do
  before(:each) do
    @assignment_set = assign(:assignment_set, AssignmentSet.create!())
  end

  it "renders the edit assignment_set form" do
    render

    assert_select "form[action=?][method=?]", assignment_set_path(@assignment_set), "post" do
    end
  end
end
