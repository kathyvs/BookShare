require 'pundit'
#require 'active_record/errors'

class ApplicationController < ActionController::Base
  include Pundit
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?
  
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
   
  def not_found
    return head(:not_found)
  end
  
  def user_not_authorized
    if current_user.nil?
      return head(:unauthorized)
    else 
      return head(:forbidden)
    end
  end
  
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [profiles_attributes: [:name]])
  end
end
