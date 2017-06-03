require 'rails_helper'

RSpec.describe "events/edit", type: :view do
  before(:each) do
    pending "A valid create method"
    @event = assign(:event, Event.create!(
      :name => "MyString"
    ))
  end

  it "renders the edit event form" do
    pending "A valid create method"
       
    render

    assert_select "form[action=?][method=?]", event_path(@event), "post" do

      assert_select "input[name=?]", "event[name]"
    end
  end
end
