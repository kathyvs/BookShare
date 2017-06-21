class SessionsController < ApplicationController
    
    def create
      user_info = request.env["omniauth.auth"]
      puts user_info
      user = AuthUser.from_auth(user_info)
      session[:user] = Marshal.dump user
      profile = Profile.find_for_user user
      if profile
        session[:profile_id] = profile.id
        redirect_to root_path
      else
        session.delete :profile_id
        redirect_to new_profile_path
      end
    end

    def destroy
      session.delete :user
      session.delete :profile_id
    end
end
