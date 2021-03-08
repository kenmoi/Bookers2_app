class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
         

  include JpPrefecture
  jp_prefecture :prefecture_code
  
  def prefecture_name
    JpPrefecture::Prefecture.find(code: prefecture_code).try(:name)
  end
  
  def prefecture_name=(prefecture_name)
    self.prefecture_code = JpPrefecture::Prefecture.find(name: prefecture_name).code
  end

  has_many :books, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  has_many :follower_relationships, class_name: "Relationship", foreign_key: "follower_id"
  # ↓「follower_relationships」を通してフォローするユーザーのIDを取得できるようになる
  has_many :followers, through: :follower_relationships, source: :followed
  has_many :followed_Relationships, class_name: "Relationship", foreign_key: "followed_id"
  has_many :followeds, through: :followed_Relationships, source: :follower
  attachment :profile_image

  # 既にフォロー済みであれば、trueを返す
  def following?(other_user)
    self.followers.include?(other_user)
    # Relationship.find_by(followed_id: other_user.id, follower_id: self.id).present?
  end

  # ユーザーをフォローする
  def follow(other_user)
    unless self == other_user
    self.follower_relationships.create(followed_id: other_user.id)
    end
  end

  # フォローを解除する
  def unfollow(other_user)
    self.follower_relationships.find_by(followed_id: other_user.id).destroy
  end

  validates :name, uniqueness: true, length: { minimum: 2, maximum: 20 }
  validates :introduction, length: { maximum: 50 }
  validates :postal_code, presence: true
  validates :prefecture_code, presence: true
  validates :address_city, presence: true
  validates :address_street, presence: true
  validates :address_building, presence: true 
  
  def self.search(search,word)
    if search == "matchs"
      @user = User.where("name LIKE?","#{word}")
    elsif search == "forward"
      @user = User.where("name LIKE?","#{word}%")
    elsif search == "backward"
      @user = User.where("name LIKE?","%#{word}")
    elsif search == "partical"
      @user = User.where("name LIKE?","%#{word}%")
    else
      @user = User.all
    end
  end
end