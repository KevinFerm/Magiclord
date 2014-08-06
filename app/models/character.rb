class Character < ActiveRecord::Base
  validates_uniqueness_of :LastName
  belongs_to :user
  belongs_to :charclass
  belongs_to :race
end
