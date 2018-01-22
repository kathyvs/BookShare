require 'rails_helper'
require 'support/capybara'
require 'support/factory_bot'

RSpec.describe "Assignment set features", type: :feature do
  include PageHelper

  feature 'Displaying all assignments for an event' do
    background do
      create(:mar_user_assignments)
      create(:mar_admin_assignments)
    end

    scenario "When there is no one logged in" do
      visit_page :root do
        expect(page).to have_content("Admin")
        expect(page).to have_content("User")
        expect(page).to include_book("Parker")
      end
    end
  end
end

