class SearchsController < ApplicationController

  def search
    @model = params[:model]
    word = params[:word]
    search = params[:search]

    if @model == '1'
      @user = User.search(search,word)
    else
      @book = Book.search(search,word)
    end
  end
end