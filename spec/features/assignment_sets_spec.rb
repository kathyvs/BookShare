require 'rails_helper'
require 'support/capybara'
require 'support/factory_bot'

RSpec.describe "Assignment set features", type: :feature do
  include PageHelper

  feature 'displaying all assignments for an event' do
    background do
      parker = create(:parker)
      ssno = create(:ssno)
      user_set = create(:mar_user_assignments)
      user_set[parker] = 1
      user_set[ssno] = 1
      user_set.event.counts = {parker.id => 23}
      user_set.event.save!
      user_set.save!

      admin_sets = create(:mar_admin_assignments)
      admin_sets[parker] = 1
      admin_sets.event = user_set.event
      admin_sets.save!
    end

    scenario "When there is no one logged in", js: true do
      visit_page :root do |page|
        expect(page).to have_content("Admin")
        expect(page).to have_content("Test User")
        expect(page).to have_content("Parker, James")
        expect(page).to have_content("21")
      end
    end
  end
end

