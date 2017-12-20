module AuthUserHelper
  
  def setup_auth_user(user)
      user.profiles << Profile.new if user.profiles.empty?
      user
    end
end
