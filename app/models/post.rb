class Post < ApplicationRecord
  belongs_to :user
  validates :img, presence: true
  validates :comment, presence: false, length: { maximum: 255 }

  mount_uploader :img, ImageUploader
  
  has_many :favorite_posts, foreign_key: 'post_id', dependent: :destroy
  has_many :users, through: :favorite_posts
end
