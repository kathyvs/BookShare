require 'rails_helper'

RSpec.describe "profiles/index", type: :view do
  before(:each) do
    pending "A valid create method"
    assign(:profiles, [
      Profile.create!(
        :name => "Name"
      ),
      Profile.create!(
        :name => "Name"
      )
    ])
  end

  it "renders a list of profiles" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
  end
end
