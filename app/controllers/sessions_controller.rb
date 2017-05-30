class SessionsController < ApplicationController
    
    def create
      user_info = request.env["omniauth.auth"]
      
      user = AuthUser.from_auth(user_info)
      session[:user] = user
      redirect_to new_profile_path
    end
end
