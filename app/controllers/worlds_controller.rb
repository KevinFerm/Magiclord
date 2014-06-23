class WorldsController < ApplicationController
  def index #Index
    @location = get_location
    if @location.connect != '' # If its not empty fetch them. Should alwhays be one since we should be able to return
      @connects = @location.connect.split(', ')
      @paths = World.find(@connects)
    end
  end

  def show #Show whats in map should contain security to check if they can go there
    @location = get_location
    @connects = @location.connect.split(', ')
    @connects.each do |connect|
      if connect == params[:id] # Need to add hidden and lock check and add update user poss
        session[:location] = params[:id]
        redirect_to worlds_path
        return
      end
    end
    redirect_to worlds_path
  end

  def create # Add Generation later
    @world = World.new(world_params)
    @biome = Biomes.all.map { |p| [p.title, p.title] }
    if @world.save
      redirect_to @world
    else
      render 'new'
    end
  end

  def new
    @world = World.new
    @all = World.all
  end
end


private
  def get_location
    if session[:location]
      World.find(session[:location])
    else
      World.find(1) # Overwrite session if none exsist but there should
    end
  end

  def world_params
    params.require(:world).permit(:title, :size, :connect)
  end