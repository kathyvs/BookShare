module Pages
  
  class RegistrationPage
    include Capybara::DSL

    def name=(name)
      fill_in('Society name', with: name)
    end
    
    def email=(email)
      fill_in('Email', with: email)
    end
    
    def password=(password)
      fill_in('Password', with: password)
    end
    
    def password_confirmation=(password)
      fill_in('Password confirmation', with: password)
    end
    
    def signup
      click_button('Sign up')
    end
  end
end    
