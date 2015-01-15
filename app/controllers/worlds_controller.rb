class WorldsController < ApplicationController
  def index #Index
    if session[:battle]
      redirect_to battles_path
      return
    end
    @location = get_location
    if @location.connect != '' # If its not empty fetch them. Should always be one since we should be able to return
      @connects = @location.connect.split(', ')
      @paths = World.find(@connects)
      @my_player = current_user.characters.where(Status: 1).first
      @players = Character.where(location: @location.id)
      @npcs = Npc.where(location: @location.id)
      @objects = WorldMaterials.where(location: @location.id,explored:1)
      @caves = Caves.where(location: @location.id, explored:1)
      @dungeons = Dungeons.where(location: @location.id, explored:1)
      if @paths.count < 4
        for i in 0..5
          generate_new_area
        end
        redirect_to worlds_path
      end
    end
  end

  def show #Show whats in map should contain security to check if they can go there
    @location = get_location
    biome = Biome.where(title: get_location.biome).first
    @connects = @location.connect.split(', ')
    @connects.each do |connect|
      if connect == params[:id] # Need to add hidden and lock check and add update user poss
        if Random.rand(100) < biome.lost_chance
          all = @connects
          session[:location] = all[Random.rand(all.count)]
          redirect_to worlds_path
          return
        else
          session[:location] = params[:id]
          user = current_user.characters.where(Status: 1).first
          user.location = params[:id]
          user.save
          redirect_to worlds_path
          return
        end
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


  def get_teleport
        session[:location] = @post.id
  end

  def generate_new_area
    curr_location = World.find(session[:location])
    # Set direction and check if we return the same and if we do there cant be one generated and skip everything since
    # we connected it instead
    cord = add_cord
    curr_compass = curr_location.compass.split(', ')
    if cord != curr_compass
      this_location = World.new
      if Random.rand(curr_location.size) <= 150
        curr_temp = Biome.where(title: curr_location.biome).first.temp
        this_temp = curr_temp + (Random.rand(10) - 5)
        this_biome = Biome.order("abs('temp' - #{this_temp})").first # Pick the biome closes to the temperature
        this_location.title = this_biome.title
        this_location.biome = this_biome.title
      else
        this_location.title = curr_location.biome
        this_location.biome = curr_location.biome
        #Add connections
      end

      # Size Generations
      if curr_location.size_fix < 5 and curr_location.size_fix > 1
        this_location.size_fix = Random.rand((curr_location.size_fix-1)..(curr_location.size_fix+1))
      elsif curr_location.size_fix == 5
        this_location.size_fix = Random.rand((curr_location.size_fix-1)..(curr_location.size_fix))
      elsif curr_location.size_fix == 1
        this_location.size_fix = Random.rand((curr_location.size_fix)..(curr_location.size_fix+1))
      end
      this_location.size = this_location.size_fix*200 + Random.rand(100)

      this_location.connect = curr_location.id.to_s
      this_location.compass = cord[0].to_s+', '+cord[1].to_s

      this_location.finder = current_user.characters.where(Status: 1).first.FirstName

      # Save everything!
      this_location.save
      curr_location.connect += ', ' + this_location.id.to_s
      curr_location.save
      generate_secret(this_location)
    end
  end

  def claim_area
    curr_location = World.find(session[:location])
    curr_location.owner = current_user.characters.where(Status: 1).first.FirstName
    curr_location.save
    redirect_to worlds_path
  end

  def attack
    me = current_user.characters.where(Status: 1).first
    Battle.where(location: session[:location]).each do |battle|
      all = JSON.parse(battle.contestant)
      for i in 0..all.length-1
        for j in 0..all[i]['players'].length-1
          puts (all[i]['players'][j]["id"].to_i)
          puts (params[:target_id].to_i)
          puts (all[i]['players'][j]["npc"].to_s == params[:npc].to_s)
          puts ("-----")
          if all[i]['players'][j]["id"].to_i == params[:target_id].to_i && all[i]['players'][j]["npc"].to_s == params[:npc].to_s
            session[:battle] = true
            all << {'players' => [{"id" => me.id, "npc" => false, "attack" =>{"id" => 0, "target" => 0,"npc" => nil}}]}
            #puts all
            all = all.to_s
            all = all.gsub! '=>', ':'
            all = all.gsub! 'nil', 'null'
            battle.contestant = all
            battle.save
            redirect_to battles_path
            return
          end
        end
      end
    end
    # Create a new combat if target is already in a fight!
    battle = Battle.new
    battle.location = session[:location]
    battle.contestant = '[{"players":[{"id":'+me.id+',"npc":false,"attack":{"id":0,"target":0,"npc":null}}]},{"players":[{"id":'+params[:target_id].to_i+',"npc":'+params[:npc].to_s+',"attack":{"id":0,"target":0,"npc":null}}]}]'
    battle.save
    session[:battle] = true
    redirect_to battles_path
    return
  end

  def search_location
    caves = Caves.where(location: session[:location], explored:0)
    dungeons = Dungeons.where(location: session[:location], explored:0)
    materials = WorldMaterials.where(location: session[:location],explored:0)
    constructions = nil
    all = [materials,caves,dungeons,constructions,nil]
    hidden = all[Random.rand(all.count)]
    if !hidden.nil? && hidden.count != 0
      obj = hidden[Random.rand(hidden.count)]
      if defined?(obj.find_chance)
        if Random.rand(obj.find_chance) == 0
          obj.explored = 1
        end
      else
        obj.explored = 1
      end
      obj.save
    end
    redirect_to worlds_path
  end

  def collect_world_item
    id = params[:id]
    obj = WorldMaterials.find(id)
    if Random.rand(obj.loot_chance) == 0
      obj.amount -= 1
      #Find inventory space here
      Item.where(equip: current_user.characters.where(Status: 1).first.FirstName).each do |item|
        Inventory.where(item_id: item.id).each do |inv|
          curr_weight = 0
          inv.items.each do |i|
            curr_weight += i.weight
          end
          if curr_weight+obj.weight < inv.max_weight && inv.items.count + 1 < inv.size
            inv.items.create(name: obj.name, size: 1, weight: obj.weight)
            obj.save
            if obj.amount == 0
              obj.destroy
            end
          end
        end
      end
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

# Secrets is hidden items like caves, dungeons and materials like herbs or ores.
  def generate_secret(size=1, location) # Need adjustments
    materials = Material.all
# Dungeons has a 50% of having 0 to size/4 puzzle rooms
# Dungeons has 0 to size/4 loot rooms
# Dungeons has 25% to contain bosses
# Dungeons rooms has 5% to contain a boss
# Dungeons rooms has 50% to contain 0 to max_amount_monster

    if Random.rand(1000) < 1
      dungeon = Dungeons.new
      dungeon.name = 'Dungeon Name Generator'
      dungeon.location = location.id
      dungeon.size = Random.rand(location.size/4)
      dungeon.explored = 0
      if Random.rand(1) == 0
        dungeon.amount_puzzle_room = Random.rand(dungeon.size/4)
      else
        dungeon.amount_puzzle_room = 0
      end
      dungeon.amount_loot_room = Random.rand(dungeon.size/4)
      dungeon.current_room = 'Entrance'
      dungeon.typ = 'Dungeon'
      dungeon.max_amount_monster = Random.rand(dungeon.size/8)
      if Random.rand(4) == 0
        dungeon.max_amount_boss = Random.rand(dungeon.size/16)
        dungeon.boss = false
      end
    end

    for i in 0..(location.size/150).to_i
      if Random.rand(200/location.size+1) < 1
        cave = Caves.new
        cave.name = 'Cave Entrance'
        cave.location = location.id
        cave.size = Random.rand(location.size/8) + 1
        cave.explored = 0
        cave.typ = ''
        materials.each do |m|
          if m.biome.include? 'Cave'
            if m.biome.include? location.biome
                if Random.rand(1) == 0
                if Random.rand(m.rarity) == 0
                  cave.typ = m.name
                end
              end
            end
          end
        end

        cave.save
      end
    end

    materials.each do |m|
      if m.biome.include? location.biome
        if Random.rand(m.rarity) == 0
          quanity = (m.quanity/2).to_i
          for x in 0..Random.rand(quanity)+quanity
            material = WorldMaterials.new
            material.name = m.name
            material.typ = m.typ
            material.amount = Random.rand(quanity) + quanity
            material.loot_chance = Random.rand(m.rarity)+(m.rarity/4) + 1
            material.find_chance = Random.rand(m.rarity)+(m.rarity/4) + 1
            material.location = location.id
            material.weight = Random.rand(m.size/2) + (m.size/2)
            material.explored = 0
            material.save
          end
        end
      end
    end
  end
