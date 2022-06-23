class DrinkComment < ApplicationRecord

  belongs_to :user
  belongs_to :drink

  validates :comment, presence: true

end
