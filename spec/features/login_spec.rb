require 'rails_helper'
require 'support/capybara'
require 'support/factory_bot'

RSpec.describe "Signin features", type: :feature do
  include PageHelper
  
  feature "Signing in" do
    
    background do
      @user = create(:user)
      @user.confirm
      create(:january_event)
    end
    
    scenario "Signing in directly with correct credentials" do
      
      visit_page :signin do |signin_page|
        signin_page.signin_as(@user.email, @user.password)
      end
      expect(page).to have_current_path(root_path)
    end
  end
end