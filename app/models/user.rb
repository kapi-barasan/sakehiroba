class User < ApplicationRecord

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

         has_many :drinks
         has_many :drink_comments, dependent: :destroy

  #画像表示用
  has_one_attached :image

  validates :name, length: { minimum: 1, maximum: 20 }, uniqueness: true

  #画像添付の際のデフォルト画像の指定
  def get_image(width, height)
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image.variant(resize_to_limit: [width, height]).processed
  end

  #ゲストユーザーの情報生成
  def self.guest
    find_or_create_by!(name: 'ゲストユーザー' ,email: 'guest@example.com') do |user|
    user.password = SecureRandom.urlsafe_base64
    user.name = "ゲストユーザー"
    end
  end

end
