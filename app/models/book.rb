class Book < ApplicationRecord
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :post_comments, dependent: :destroy

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end


def self.search(search,word)
  if search == "matchs"
    @book = Book.where("title LIKE?","#{word}")
  elsif search == "forward"
    @book = Book.where("title LIKE?","#{word}%")
  elsif search == "backward"
    @book = Book.where("title LIKE?","%#{word}")
  elsif search == "partical"
    @book = Book.where("title LIKE?","%#{word}%")
  else
    @book = Book.all
  end
end

   validates :title, presence: true
   validates :body, presence: true, length: { maximum: 200 }
end
