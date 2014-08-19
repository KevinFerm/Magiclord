class ApplicationController < ActionController::Base
  helper_method :have_character
  def have_character
    if user_signed_in?
      @user = current_user.characters.where(Status: 1).inspect
      if @user.nil?
        return false
      else
        return true
      end
    end
  end
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception


end
