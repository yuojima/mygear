class User < ApplicationRecord
  before_save { self.email.downcase! }
  validates :name, presence: true, length: { maximum: 32 }
  validates :email, presence: true, length: { maximum: 32 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
  validates :password_digest, presence: true, length: { maximum: 64 }
  
  has_secure_password
  
  has_many :posts
  
  has_many :follow_users
  has_many :followings, through: :follow_users, source: :follow
  has_many :reverses_of_follow_users, class_name: 'Follow_user', foreign_key: 'follow_id'
  has_many :followers, through: :reverses_of_follow_users, source: :user
  
  has_many :favorite_posts
  has_many :favors, through: :favorite_posts, source: :post
end
