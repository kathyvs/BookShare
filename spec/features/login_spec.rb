require 'rails_helper'
require 'support/capybara'
require 'support/factory_bot'
require 'support/database_cleaner'

RSpec.describe "Signin features", type: :feature do
  include PageHelper

  feature "Signing in" do

    background do
      @profile = create_profile(:profile)
      @user = @profile.user
      @user.confirm
      create(:january_event)
    end

    scenario "Signing in directly with correct credentials" do

      visit_page :signin do |signin_page|
        signin_page.signin_as(@user.email, @user.password)
      end
      expect(page).to have_current_path(root_path)
      expect(nav_bar).to show_login_as(@profile)
    end
  end
end
