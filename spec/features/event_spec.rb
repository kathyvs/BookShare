require 'rails_helper'
require 'support/capybara'
require 'support/factory_bot'
require 'support/database_cleaner'

RSpec.describe "Event features", type: :feature do

  include PageHelper


  feature "creating an event" do

    before do
      create(:parker)
      create(:ssno)
      create(:bahlow)
      create(:ncmj)
    end

    scenario "when not logged in" do
      visit_page :new_event do |page|
        expect(page.status).to match(:unauthorized)
      end
    end

    scenario "when not authorized" do
      login_as(:profile)
      visit_page :new_event do |page|
        expect(page.status).to match(:forbidden)
      end
    end

    scenario "successfully creating an event and assigning books", js: true do
      login_as(:admin)
      visit_page :new_event do |page|
        page.name = 'Simple Test Event'
        page.month = 'October'
        page.submit do |next_page|
          next_page.at_row(:parker).books = 215
          next_page.at_row(:bahlow).books = 1
          next_page.at_row(:ssno).set_show_to(false)
          next_page.submit do |final_page|
            expect(final_page).to have_current_path(root_path)
            expect(final_page).to have_text("Simple Test Event Book")
            expect(final_page).to have_text('215')
            expect(nav_bar)
          end
        end
      end
    end
  end

end
