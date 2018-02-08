require 'rails_helper'

RSpec.describe "event_assignment_sets/new", type: :view do
  before(:each) do
    assign(:event_assignment_set, EventAssignmentSet.new(
      :event => "",
      :year => "",
      :books => ""
    ))
  end

  it "renders new event_assignment_set form" do
    render

    assert_select "form[action=?][method=?]", event_assignment_sets_path, "post" do

      assert_select "input[name=?]", "event_assignment_set[event]"

      assert_select "input[name=?]", "event_assignment_set[year]"

      assert_select "input[name=?]", "event_assignment_set[books]"
    end
  end
end
