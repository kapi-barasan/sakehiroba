class Drink < ApplicationRecord
  belongs_to :user
  
  #画像表示用
  has_one_attached :image
  
end
