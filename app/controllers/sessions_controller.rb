class SessionsController < ApplicationController
    
    def create
      user_info = request.env["omniauth.auth"]
      puts user_info
      user = AuthUser.from_auth(user_info)
      session[:user] = Marshal.dump user
      profile = Profile.find_for_user user
      print "Profile id: #{profile.id}\n" if profile
      session[:profile_id] = profile.id if profile
      redirect_to new_profile_path
    end
end
