require 'pundit'
require 'user_helper'

class ApplicationController < ActionController::Base
  include Pundit
  include UserHelper
  protect_from_forgery with: :exception

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def user_not_authorized
    if current_user.nil?
      return head(:unauthorized)
    else 
      return head(:forbidden)
    end
  end
end
