require 'capybara/rspec'
require 'support/database_cleaner'
require 'support/user_helper'

Dir[Rails.root.join('spec/features/pages/**/*.rb')].each { |f|
  require f }

Capybara.register_driver :selenium_chrome do |app|
  Capybara::Selenium::Driver.new(app, browser: :chrome)
end

Capybara.javascript_driver = :selenium_chrome

module PageHelper

  include UserHelper

  def common_elements
    Pages::Page.new
  end

  def nav_bar
    common_elements.nav_bar
  end

  def visit_page(page_sym, **params)
    visit send(pages[page_sym][:url], **params)
    yield pages[page_sym][:page].new
  end

  private

    def pages
      @pages ||= {
        root: {url: :root_path, page: Pages::AssignmentsPage},
        signin: {url: :new_auth_user_session_path, page: Pages::LoginPage},
        registration: {url: :new_auth_user_registration_path, page: Pages::RegistrationPage},
        new_event: {url: :new_event_path, page: Pages::EditEventPage}
        }
    end
end

module PageMatchers

  extend Pages::NavigationBar::Matchers

end

