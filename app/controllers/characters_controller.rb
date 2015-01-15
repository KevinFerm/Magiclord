class CharactersController < ApplicationController
  def new
    if user_signed_in?
      @user = current_user
      @char = @user.characters.where(Status: 1)
      @random = Random.rand(World.all.count)
      if @char[0]
        redirect_to home_index_path
      end
    end
  end

  def create # Add Generation later

    @char = current_user.characters.new(char_params)
    @char.effect = "[]"
    @char.Curr_Hp = max_health(@char)
    @char.Curr_Stamina = max_stamina(@char)
    if @char.save
      inv = @char.inventories.create(name: char_params[:FirstName], size:10, max_weight:15)
      item = inv.items.create(name: "Backpack", size:1, weight:1, equip: "Back", material: "Leather")
      bag = item.inventories.create(name: "Big Slot", size:10, max_weight:15)
      # Put fun start items here
      # Generate a random gem for new users, atm useing predefined but will add auto-generated later
      num = Random.rand(0..7)
      hand = "Left "
      if num == 0
        perl = inv.items.create(name: "Gem of Fire", size:1, weight:1, equip: hand+"Hand", material: "Gem")
        perl.pearls.create(title: "Fireball",parts:"{}", type:"Magic",ep:10,curr_ep:10,effect:'{"damage":10,"dot":{"name":"Burn","damage":5,"turn":10,"target":"target"}}', desc:"Shoots a fireball on target and leave a burn")
      elsif num == 1
        perl = inv.items.create(name: "Gem of Ice", size:1, weight:1, equip: hand+"Hand", material: "Gem")
        perl.pearls.create(title: "Iceball",parts:"{}", type:"Magic",ep:10,curr_ep:10,effect:'{"damage":5,"dot":{"name":"Freeze","damage":5,"turn":20,"target":"target"}}', desc:"Shoots a Iceball on target and leave a freeze")
      elsif num == 2
        perl = inv.items.create(name: "Gem of Water", size:1, weight:1, equip: hand+"Hand", material: "Gem")
        perl.pearls.create(title: "Waterblast",parts:"{}", type:"Magic",ep:10,curr_ep:10,effect:'{"damage":20}', desc:"Shoots a stream of water on target")
      elsif num == 3
        perl = inv.items.create(name: "Gem of Lava", size:1, weight:1, equip: hand+"Hand", material: "Gem")
        perl.pearls.create(title: "Lava pool",parts:"{}", type:"Magic",ep:10,curr_ep:10,effect:'{"damage":0,"dot":{"name":"Burn","damage":25,"turn":3,"target":"target"}}', desc:"Put a pool of lava under target and leave a burn effect")
      elsif num == 4
        perl = inv.items.create(name: "Gem of Heal", size:1, weight:1, equip: hand+"Hand", material: "Gem")
        perl.pearls.create(title: "Healing",parts:"{}", type:"Magic",ep:10,curr_ep:10,effect:'{"damage":-20}', desc:"Heal target")
      elsif num == 5
        perl = inv.items.create(name: "Gem of Healing Wave", size:1, weight:1, equip: hand+"Hand", material: "Gem")
        perl.pearls.create(title: "Healing Wave",parts:"{}", type:"Magic",ep:10,curr_ep:10,effect:'{"damage":0,"dot":{"name":"Heal","damage":-10,"turn":20,"target":"target"}}', desc:"Heal target over turns")
      elsif num == 6
        perl = inv.items.create(name: "Gem of Blood Heal", size:1, weight:1, equip: hand+"Hand", material: "Gem")
        perl.pearls.create(title: "Blood Heal",parts:"{}", type:"Magic",ep:10,curr_ep:10,effect:'{"damage":100,"dot":{"name":"Heal","damage":-40,"turn":5,"target":"target"}}', desc:"Do damage and heal the double of the damage taken over time")
      elsif num == 7
        perl = inv.items.create(name: "Gem of Random", size:1, weight:1, equip: hand+"Hand", material: "Gem")
        perl.pearls.create(title: "Random",parts:"{}", type:"Magic",ep:10,curr_ep:10,effect:'{"damage":'+Random.rand(-50..50)+',"dot":{"name":"Random","damage":'+Random.rand(-15..15)+',"turn":'+Random.rand(2..5)+',"target":"target"}}', desc:"This gem was random generated so no one will know what it does")
      end

      num = Random.rand(0..7)
      hand = "Right "
      if num == 0
        perl = inv.items.create(name: "Gem of Fire", size:1, weight:1, equip: hand+"Hand", material: "Gem")
        perl.pearls.create(title: "Fireball",parts:"{}", type:"Magic",ep:10,curr_ep:10,effect:'{"damage":10,"dot":{"name":"Burn","damage":5,"turn":10,"target":"target"}}', desc:"Shoots a fireball on target and leave a burn")
      elsif num == 1
        perl = inv.items.create(name: "Gem of Ice", size:1, weight:1, equip: hand+"Hand", material: "Gem")
        perl.pearls.create(title: "Iceball",parts:"{}", type:"Magic",ep:10,curr_ep:10,effect:'{"damage":5,"dot":{"name":"Freeze","damage":5,"turn":20,"target":"target"}}', desc:"Shoots a Iceball on target and leave a freeze")
      elsif num == 2
        perl = inv.items.create(name: "Gem of Water", size:1, weight:1, equip: hand+"Hand", material: "Gem")
        perl.pearls.create(title: "Waterblast",parts:"{}", type:"Magic",ep:10,curr_ep:10,effect:'{"damage":20}', desc:"Shoots a stream of water on target")
      elsif num == 3
        perl = inv.items.create(name: "Gem of Lava", size:1, weight:1, equip: hand+"Hand", material: "Gem")
        perl.pearls.create(title: "Lava pool",parts:"{}", type:"Magic",ep:10,curr_ep:10,effect:'{"damage":0,"dot":{"name":"Burn","damage":25,"turn":3,"target":"target"}}', desc:"Put a pool of lava under target and leave a burn effect")
      elsif num == 4
        perl = inv.items.create(name: "Gem of Heal", size:1, weight:1, equip: hand+"Hand", material: "Gem")
        perl.pearls.create(title: "Healing",parts:"{}", type:"Magic",ep:10,curr_ep:10,effect:'{"damage":-20}', desc:"Heal target")
      elsif num == 5
        perl = inv.items.create(name: "Gem of Healing Wave", size:1, weight:1, equip: hand+"Hand", material: "Gem")
        perl.pearls.create(title: "Healing Wave",parts:"{}", type:"Magic",ep:10,curr_ep:10,effect:'{"damage":0,"dot":{"name":"Heal","damage":-10,"turn":20,"target":"target"}}', desc:"Heal target over turns")
      elsif num == 6
        perl = inv.items.create(name: "Gem of Blood Heal", size:1, weight:1, equip: hand+"Hand", material: "Gem")
        perl.pearls.create(title: "Blood Heal",parts:"{}", type:"Magic",ep:10,curr_ep:10,effect:'{"damage":100,"dot":{"name":"Heal","damage":-40,"turn":5,"target":"target"}}', desc:"Do damage and heal the double of the damage taken over time")
      elsif num == 7
        perl = inv.items.create(name: "Gem of Random", size:1, weight:1, equip: hand+"Hand", material: "Gem")
        perl.pearls.create(title: "Random",parts:"{}", type:"Magic",ep:10,curr_ep:10,effect:'{"damage":'+Random.rand(-50..50)+',"dot":{"name":"Random","damage":'+Random.rand(-15..15)+',"turn":'+Random.rand(2..5)+',"target":"target"}}', desc:"This gem was random generated so no one will know what it does")
      end

      redirect_to home_index_path
    else
      render 'new'
    end
  end

private
  def char_params
    params.require(:character).permit(:FirstName, :LastName, :Age, :Class, :Race, :location, :Strength, :Agility, :Intelligence, :Stamina, :Primary_Profession, :Secondary_Profession)
  end


end