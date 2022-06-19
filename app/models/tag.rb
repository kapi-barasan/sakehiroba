class Tag < ApplicationRecord
  has_many   :drink_tags, dependent: :destroy
  has_many   :drinks, through: :drink_tags
  validates :name, uniqueness: true
end
