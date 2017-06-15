class SessionsController < ApplicationController
    
    def create
      user_info = request.env["omniauth.auth"]
      puts user_info
      user = AuthUser.from_auth(user_info)
      session[:user] = user
      profile = Profile.find_for_user user
      session[:profile_id] = profile.id if profile
      redirect_to new_profile_path
    end
end
