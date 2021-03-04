class FavoritesController < ApplicationController

  def create
    # book = Book.find(params[:book_id])
    # favorite = current_user.favorites.new(book_id: book.id)
    # favorite.save
    user = User.find(params[:followed_id])
    current_user.follow(user)
    redirect_back(fallback_location: root_path)
  end

  def destroy
    # book = Book.find(params[:book_id])
    # favorite = current_user.favorites.find_by(book_id: book.id)
    # favorite.destroy
    user = Relationship.find(params[:id]).followed
    current_user.unfollow(user)
    redirect_back(fallback_location: root_path)
  end

end
