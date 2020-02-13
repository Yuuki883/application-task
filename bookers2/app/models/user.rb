class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable,:validatable

  has_many :books, dependent: :destroy
  has_many :bookcomments
  has_many :favorites, dependent: :destroy
  has_many :favorited_posts, through: :favorites, source: :post

  has_many :following_relationships, foreign_key: "follower_id", class_name: "Relationship", dependent: :destroy
  has_many :followings, through: :following_relationships
  has_many :follower_relationships, foreign_key: "following_id", class_name: "Relationship", dependent: :destroy
  has_many :followers, through: :follower_relationships

    def already_favorited?(book)
      self.favorites.exists?(book_id: book.id)
    end

    def following?(other_user)
      following_relationships.find_by(following_id: other_user.id)
    end

    def follow!(other_user)
      following_relationships.create!(following_id: other_user.id)
    end

    def unfollow!(other_user)
      following_relationships.find_by(following_id: other_user.id).destroy
    end

  attachment :profile_image, destroy: false

  validates :name, presence: true, length: {maximum: 20, minimum: 2}
  validates :introduction, length: { maximum: 50 }
end
