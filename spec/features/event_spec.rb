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
      visit_page :new_event do |edit_page|
        edit_page.name = 'Simple Test Event'
        edit_page.month = 'October'
        table = edit_page.table
        table.at_row(:parker).books = 215
        table.at_row(:bahlow).books = 1
        table.at_row(:ssno).set_show_to(false)
        edit_page.submit do|final_page|
          expect(final_page).to have_current_path(/events/)
          expect(final_page).to have_text("Simple Test Event Book")
          expect(final_page).to have_text('215')
        end
      end
    end
  end

end
