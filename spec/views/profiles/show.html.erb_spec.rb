require 'rails_helper'

RSpec.describe "events/show", type: :view do
  before(:each) do
    pending "A valid create method"
    @event = assign(:event, Event.create!(
      :name => "Name"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
  end
end
