class Inventory < ActiveRecord::Base
  has_many :items, dependent: :destroy
  belongs_to :character
  belongs_to :item
end
