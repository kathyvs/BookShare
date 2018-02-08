require 'rails_helper'

RSpec.describe "event_assignment_sets/edit", type: :view do
  before(:each) do
    @event_assignment_set = assign(:event_assignment_set, EventAssignmentSet.create!(
      :event => "",
      :year => "",
      :books => ""
    ))
  end

  it "renders the edit event_assignment_set form" do
    render

    assert_select "form[action=?][method=?]", event_assignment_set_path(@event_assignment_set), "post" do

      assert_select "input[name=?]", "event_assignment_set[event]"

      assert_select "input[name=?]", "event_assignment_set[year]"

      assert_select "input[name=?]", "event_assignment_set[books]"
    end
  end
end
