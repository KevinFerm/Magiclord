class HomeController < ApplicationController
  before_action :authenticate_user!
  def index
    @username = current_user
    session[:location] = current_user.characters.where(Status: 1).first.location

    @admin = User.where("admin = 't'").first
    if @admin.nil?
      @admin_claim = true
    else
      @admin_claim = false
    end
  end

  helper_method :claim_admin
  def claim_admin
    current_user.admin = 't'
    current_user.save
  end
end
