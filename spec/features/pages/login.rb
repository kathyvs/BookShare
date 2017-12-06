
module Pages
  
  class LoginPage
    include Capybara::DSL
    include FactoryBot::Syntax::Methods
    
    def signin_as(email_or_sym, password=nil)
      if (email_or_sym.is_a? Symbol)
        user = create(email_or_sym)
        user.confirm
        email_or_sym = user.email
        password = user.password
      end
      within('#new_auth_user') do
        fill_in 'Email', with: email_or_sym
        fill_in 'Password', with: password
        click_button 'Log in'
      end
    end
  end
end