require 'pundit'
#require 'active_record/errors'

class ApplicationController < ActionController::Base
  include Pundit
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  rescue_from Mongoid::Errors::DocumentNotFound, with: :not_found

  def event
    @event ||= Event.current(params[:event_id])
  end

  def year
    @year ||= (params[:year]&.to_i || Date.today.year)
  end

  def not_found
    return head(:not_found)
  end

  def user_not_authorized
    if current_auth_user.nil?
      return head(:unauthorized)
    else
      return head(:forbidden)
    end
  end

  def current_user # needed for Pundit
    current_auth_user
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [profiles_attributes: [:name]])
  end

end
