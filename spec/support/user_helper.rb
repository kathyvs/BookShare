
module UserHelper

  attr_reader :current_user

  def login_help
    @login_help ||= LoginHelper.new
  end

  def login_as(profile)
    logout if current_user
    profile = create_profile(profile) unless profile.respond_to?(:user)
    @current_user = profile.user
    login_help.login_as(current_user)
  end

  def logout
    login_help.logout(current_user)
  end

  def create_profile(profile_sym)
    new_profile = build(profile_sym)
    q = Profile.where(name: new_profile.name)
    return q.first if q.exists?
    new_profile.user.confirm
    new_profile.save
    return new_profile
  end


  class LoginHelper

    include Warden::Test::Helpers

  end

end
