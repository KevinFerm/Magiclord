class CharactersController < ApplicationController
  def new
    if user_signed_in?
      @user = User.find(current_user.id)
      if @user.characters.where(Status: 1).nil?
        redirect_to home_index_path
      else

      end
    end
  end

  def create # Add Generation later
    @char = User.find(current_user.id).characters.new(char_params)
    if @char.save
      redirect_to home_index_path
    else
      render 'new'
    end
  end

private
  def char_params
    params.require(:character).permit(:FirstName, :LastName, :Age, :Class, :Race)
  end


end