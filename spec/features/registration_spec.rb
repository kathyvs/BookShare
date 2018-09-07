require 'rails_helper'
require 'support/capybara'
require 'support/factory_bot'

RSpec.describe "Registration features", type: :feature do
  include PageHelper

  feature 'Registering new user' do
    background do
      create(:january_event)
    end

    scenario "Creating account with correct features" do


      visit_page :registration do |rpage|
        rpage.name = name = 'Test User'
        rpage.email = email = 'test@test.kathyvs.net'
        rpage.password = password = 'pwd4test'
        rpage.password_confirmation = password
        rpage.signup

        expect(AuthUser.where(email: email)).to contain_exactly(an_user_with_name(name))
      end
      expect(page).to have_current_path(root_path)
      expect(common_elements.notice).to have_content("confirmation")
      expect(nav_bar).to_not be_signed_in
    end

    def an_user_with_name(name)
      an_object_satisfying do |o|
        o.current_profile && o.current_profile.name == name
      end
    end
  end
end
