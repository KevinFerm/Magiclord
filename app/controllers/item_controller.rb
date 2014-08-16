class ItemController < ApplicationController
  def index
    @name = current_user.characters.where(Status: 1).first
    @equipments = Item.where(equip: @name.FirstName)
  end

  helper_method :get_inventory
  def get_inventory(id)
    return Inventory.where(item_id: id)
  end
end
