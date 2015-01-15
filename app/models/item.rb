class Item < ActiveRecord::Base
  belongs_to :inventory
  has_many :inventories
  has_many :pearls
end
