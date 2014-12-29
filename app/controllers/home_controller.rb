
class HomeController < ApplicationController
  before_action :authenticate_user!
  def index
    @username = current_user
    @char = @username.characters.where(Status: 1).first
    if !@char.nil?
      @found = World.where(finder: @char.FirstName)
    end
    if @char
      session[:location] = @char.location
    end


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