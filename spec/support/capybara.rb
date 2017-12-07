require 'capybara/rspec'
require 'support/database_cleaner'
require 'features/pages/login'
require 'features/pages/navigation'

Capybara.register_driver :selenium_chrome do |app|
  Capybara::Selenium::Driver.new(app, browser: :chrome)
end

Capybara.javascript_driver = :selenium_chrome

module PageHelper 

  def nav_bar
    Pages::NavigationBar.new
  end

  def visit_page(page_sym)
    visit send(pages[page_sym][:url])
    yield pages[page_sym][:page].new
  end
  
  private
  
  def pages
    @pages ||= {signin: {url: :new_auth_user_session_path, page: Pages::LoginPage}}
  end
end

module PageMatchers

  extend Pages::NavigationBar::Matchers

end

