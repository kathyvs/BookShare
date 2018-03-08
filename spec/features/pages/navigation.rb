
module Pages

  class NavigationBar
    include Capybara::DSL

    def signed_in?
      signin_name != 'Log In'
    end

    def signin_name
      within '#user_info' do
        return all("li a").first.text
      end
    end

    def nav_links
      within '.nav' do
        return all("li")
      end
    end

    module Matchers

      RSpec::Matchers.define :show_login_as  do |profile|
        match do |nav_bar|
           nav_bar.signed_in? && nav_bar.signin_name == profile.name
        end


      end

    end
  end
end
