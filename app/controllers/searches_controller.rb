class SearchesController < ApplicationController
  def search
    @range = params[:range]
    search = params[:search]
    word = params[:word]
    if @range == '1'
      @user = User.search_for(search,word)
    else
      @book = Book.search(search,word)
    end
    # binding.pry
  end
end