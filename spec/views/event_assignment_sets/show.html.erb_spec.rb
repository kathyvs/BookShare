require 'rails_helper'

RSpec.describe "event_assignment_sets/show", type: :view do
  before(:each) do
    @event_assignment_set = assign(:event_assignment_set, EventAssignmentSet.create!(
      :event => "",
      :year => "",
      :books => ""
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
  end
end
