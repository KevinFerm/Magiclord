class WorldsController < ApplicationController
  def index #Index
    @location = get_location
    if @location.connect != '' # If its not empty fetch them. Should always be one since we should be able to return
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
    @biome = Biome.all.map { |p| [p.title, p.title] }
    if @world.save
      redirect_to @world
    else
      render 'new'
    end
  end

  def new
    if current_user.try(:admin?)
      @world = World.new
      @all = World.all
      @biome = Biome.all.map { |p| [p.title, p.title] }
    else
      redirect_to worlds_path
    end
  end

  def generate_new_area
    curr_location = World.find(session[:location])
    # Set direction and check if we return the same and if we do there cant be one generated and skip everything since
    # we connected it instead
    cord = add_cord
    curr_compass = curr_location.compass.split(', ')
    if cord != curr_compass
      this_location = World.new
      if Random.rand(curr_location.size) <= 20
        curr_temp = Biome.where(title: curr_location.biome).first
        this_temp = curr_temp.temp + (Random.rand(10) - 5)
        this_biome = Biome.order("abs('temp' - #{this_temp})").first # Pick the biome closes to the temperature
        this_location.title = this_biome.title
        this_location.biome = this_biome.title
      else
        this_location.title = curr_location.biome
        this_location.biome = curr_location.biome
        #Add connections
      end

      this_location.size = curr_location.size + (Random.rand(curr_location.size) - curr_location.size/2)
      this_location.connect = curr_location.id.to_s
      this_location.compass = cord[0].to_s+', '+cord[1].to_s

      # Save everything!
      this_location.save
      curr_location.connect += ', ' + this_location.id.to_s
      curr_location.save
    end

    redirect_to worlds_path
  end
end


private
  def get_location
    if session[:location]
      World.find(session[:location])
    else
      World.find(1) # Overwrite session if none exist but there should
    end
  end

  def world_params
    params.require(:world).permit(:title, :size, :connect, :biome)
  end


# Compass
#     N
#     |
# W - o - E
#     |
#     S

  def add_cord(stack=0)
    curr_location = World.find(session[:location])
    direction = Random.rand(4)
    curr_compass = curr_location.compass.split(', ')

    x = curr_compass[0].to_i
    y = curr_compass[1].to_i
    if stack < 500
      if direction == 0
        check = World.where("compass = '#{(x+1).to_s}, #{y.to_s}'").first
        if check.nil?
          x += 1
        else
          curr_connections = curr_location.connect.split(', ')
          if curr_connections.include?(check.id.to_s)
            return add_cord(stack += 1)
          else
            connect_world(check,curr_location)
          end
        end
      elsif direction == 1
        check = World.where("compass = '#{(x-1).to_s}, #{y.to_s}'").first
        if check.nil?
          x -= 1
        else
          curr_connections = curr_location.connect.split(', ')
          if curr_connections.include?(check.id.to_s)
            return add_cord(stack += 1)
          else
            connect_world(check,curr_location)
          end
        end
      elsif direction == 2
        check = World.where("compass = '#{x.to_s}, #{(y+1).to_s}'").first
        if check.nil?
          y += 1
        else
          curr_connections = curr_location.connect.split(', ')
          if curr_connections.include?(check.id.to_s)
            return add_cord(stack += 1)
          else
            connect_world(check,curr_location)
          end
        end
      elsif direction == 3
        check = World.where("compass = '#{x.to_s}, #{(y-1).to_s}'").first
        if check.nil?
          y -= 1
        else
          curr_connections = curr_location.connect.split(', ')
          if curr_connections.include?(check.id.to_s)
            return add_cord(stack += 1)
          else
            connect_world(check,curr_location)
          end
        end
      end
    else # If there is one already on every spot we have to check if we can connect instead
      # Connect them if it is true!

    end
    return [x.to_s,y.to_s]
  end
  def connect_world(x, y)
    x.connect += ", " + y.id.to_s
    y.connect += ", " + x.id.to_s
    x.save
    y.save
  end