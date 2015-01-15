class ApplicationController < ActionController::Base
  helper_method :check_path, :attack, :have_character, :max_health, :max_stamina, :compass, :has_item

  def have_character
    if user_signed_in?
      @user = current_user.characters.where(Status: 1).first
      if @user.nil?
        return false
      else
        return true
      end
    end
  end

  def check_path
    if !have_character
      redirect_to new_character_path
    end
    if session[:battle]
      redirect_to battle_path
    end
  end

  #Get max health of given npc or character
  def max_health(stats)
    return ((stats.Strength+stats.Agility+stats.Intelligence+stats.Stamina)/4)*((stats.Stamina+stats.Strength)/2)
  end

  def max_stamina(stats)
    return ((stats.Stamina*3)+stats.Strength)*2
  end

  #Get direction from start to end
  def compass(start,stop)
    this_cord = start.compass.split(", ")
    curr_cord = stop.compass.split(", ")
    if this_cord[0].to_i < curr_cord[0].to_i #X
      compass = "East"
    elsif this_cord[0].to_i > curr_cord[0].to_i #X
      compass = "West"
    elsif this_cord[1].to_i < curr_cord[1].to_i #Y
      compass = "South"
    elsif this_cord[1].to_i > curr_cord[1].to_i #Y
      compass = "North"
    end
    return compass
  end

  def has_item(this_item)
    Item.where(equip: current_user.characters.where(Status: 1).first.FirstName).each do |item|
      if item.name == this_item
        return true
      end
      Inventory.where(item_id: item.id).each do |inv|
        inv.items.each do |i|
          if i.name == this_item
            return true
          end
        end
      end
    end
    return false
  end

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception


  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :FamilyName
  end
end
