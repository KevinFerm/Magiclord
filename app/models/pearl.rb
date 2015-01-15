class Pearl < ActiveRecord::Base
  belongs_to :item
  self.inheritance_column = nil
end
