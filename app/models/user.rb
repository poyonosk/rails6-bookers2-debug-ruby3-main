class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books, dependent: :destroy

  has_one_attached :profile_image

  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy

  validates :name, presence: true, uniqueness: true, length: {minimum: 2, maximum: 20}
  validates :introduction, presence: false, length: {maximum: 50}

  def get_profile_image
    (profile_image.attached?) ? profile_image : 'no_image.jpg'
  end

  has_many :follows, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :follower, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy

  has_many :followings, through: :follows, source: :followed
  has_many :followers, through: :follower, source: :follower

  def follow(user)
    follows.create(followed_id: user.id)
  end

  def unfollow(user)
    follows.find_by(followed_id: user.id).destroy
  end

  def following?(user)
    followings.include?(user)
  end

end
