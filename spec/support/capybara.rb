require 'capybara/rspec'
require 'support/database_cleaner'
require 'features/pages/login'

Capybara.register_driver :selenium_chrome do |app|
  Capybara::Selenium::Driver.new(app, browser: :chrome)
end

Capybara.javascript_driver = :selenium_chrome

module PageHelper 

  def pages
    @pages ||= {signin: {url: :new_auth_user_session_path, page: Pages::LoginPage}}
  end

  def visit_page(page_sym)
    visit send(pages[page_sym][:url])
    yield pages[page_sym][:page].new
  end
end

