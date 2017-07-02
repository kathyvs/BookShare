module UserHelper

  def current_user 
    @current_user ||= Marshal.load session[:user] if logged_in?
    if @current_user && session.has_key?(:profile_id)
      @current_user.profile ||= Profile.find session[:profile_id]
    end
    @current_user
  end
  
  def admin?
    current_user && current_user.admin?
  end

  def logged_in?
    session.has_key? :user
  end
end
