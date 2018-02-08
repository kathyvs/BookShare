require 'rails_helper'

RSpec.describe "event_assignment_sets/index", type: :view do
  before(:each) do
    assign(:event_assignment_sets, [
      EventAssignmentSet.create!(
        :event => "",
        :year => "",
        :books => ""
      ),
      EventAssignmentSet.create!(
        :event => "",
        :year => "",
        :books => ""
      )
    ])
  end

  it "renders a list of event_assignment_sets" do
    render
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
  end
end
