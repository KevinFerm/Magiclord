class HomeController < ApplicationController
  before_action :authenticate_user!
  def index
    @username = current_user
  end
end
