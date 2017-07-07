require 'pundit'
require 'user_helper'
#require 'active_record/errors'

class ApplicationController < ActionController::Base
  include Pundit
  include UserHelper
  protect_from_forgery with: :exception

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  #rescue_from ActiveRecord::RecordNotFound, with: :not_found
  
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
  
end
