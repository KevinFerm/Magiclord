class Item < ActiveRecord::Base
  belongs_to :inventory
  belongs_to :character
end
