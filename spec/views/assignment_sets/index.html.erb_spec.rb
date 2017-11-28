require 'rails_helper'

RSpec.describe "assignment_sets/index", type: :view do
  before(:each) do
    assign(:assignment_sets, [
      AssignmentSet.create!(),
      AssignmentSet.create!()
    ])
  end

  it "renders a list of assignment_sets" do
    render
  end
end
