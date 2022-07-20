class Drink < ApplicationRecord
  belongs_to :user

  #画像表示用
  has_one_attached :image

  has_many :drink_comments, dependent: :destroy

  has_many  :drink_tags, dependent: :destroy
    has_many  :tags, through: :drink_tags

  has_many :favorites, dependent: :destroy

  validates :name,presence:true
  validates :body,presence:true,length:{maximum:200}

  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end

  #タグ機能
  def save_tags(savedrink_tags)
      current_tags = self.tags.pluck(:name) unless self.tags.nil?
      old_tags = current_tags - savedrink_tags
      new_tags = savedrink_tags - current_tags

      old_tags.each do |old_name|
        self.tags.delete Tag.find_by(name:old_name)
      end

      new_tags.each do |new_name|
        drink_tag = Tag.find_or_create_by(name:new_name)
        self.tags << drink_tag
      end
  end

  #画像添付の際のデフォルト画像の指定
  def get_image(width, height)
      unless image.attached?
        file_path = Rails.root.join('app/assets/images/no_image.jpg')
        image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
      end
      image.variant(resize_to_limit: [width, height]).processed
  end
end
