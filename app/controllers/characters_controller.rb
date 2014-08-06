class CharactersController < ApplicationController
  def new
    if user_signed_in?
      if Character.where(Status: 1,id: current_user.id).nil?
        redirect_to home_index_path
      else

      end
    end
  end

  def create # Add Generation later
    @char = Character.new(char_params)
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