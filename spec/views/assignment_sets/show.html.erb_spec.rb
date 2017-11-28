require 'rails_helper'

RSpec.describe "assignment_sets/show", type: :view do
  before(:each) do
    @assignment_set = assign(:assignment_set, AssignmentSet.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
