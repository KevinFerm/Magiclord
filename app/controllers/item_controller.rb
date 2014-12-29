class ItemController < ApplicationController
  def index
    @name = current_user.characters.where(Status: 1).first
    @equipments = Item.where(equip: @name.FirstName)
  end

  def new
    char = current_user.characters.where(Status: 1).first.id
    @items_to_craft = Item.where(character_id:char, blueprint:true)
  end


  helper_method :get_inventory, :item_action
  def item_action(id,action)
    Item.find(id).name = "Renamed Iron"
    redirect_to item_index_path
  end
  def get_inventory(id)
    return Inventory.where(item_id: id)
  end
end
