class User < ApplicationRecord
  before_save { self.email.downcase! }
  validates :name, presence: true, length: { maximum: 32 }
  validates :email, presence: true, length: { maximum: 32 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
  validates :password_digest, presence: true, length: { maximum: 64 }
  
  has_secure_password
  
  mount_uploader :img, ImageUploader
  
  has_many :posts
  
  has_many :follow_users
  has_many :followings, through: :follow_users, source: :follow
  has_many :reverses_of_follow_users, class_name: 'FollowUser', foreign_key: 'follow_id'
  has_many :followers, through: :reverses_of_follow_users, source: :user
  
  def follow(other_user)
    unless self == other_user
      self.follow_users.find_or_create_by(follow_id: other_user.id)
    end
  end
  
  def unfollow(other_user)
    follow_user = self.follow_users.find_by(follow_id: other_user.id)
    follow_user.destroy if follow_user
  end
  
  def following?(other_user)
    self.followings.include?(other_user)
  end
  
  def feed_posts
    Post.where(user_id: self.following_ids + [self.id])
  end
  
  has_many :favorite_posts
  has_many :favors, through: :favorite_posts, source: :post
  
end