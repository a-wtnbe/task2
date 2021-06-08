class Book < ApplicationRecord
	belongs_to :user
	validates :title, presence: true
	validates :body, presence: true, length: {maximum: 200}

	has_many :favorites, dependent: :destroy
	def favorited_by?(user)
		favorites.where(user_id: user.id).exists?
	end

	has_many :book_comments, dependent: :destroy

  def self.search(search,word)
    if search == "forward_match"
      @book = Book.where("title LIKE?", "#{word}%")
    elsif search == "backward_match"
      @book = Book.where("title LIKE?","%#{word}")
    elsif search == "perfect_match"
      @book = Book.where(title: word)
    elsif search == "partial_match"
      @book = Book.where("title LIKE?","%#{word}%")
    else
      @book = Book.all
    end
  end
  
  def self.last_week
    Book.joins(:favorites).where(favorites: {created_at: 0.days.ago.prev_week..0.days.ago.prev_week(:sunday)}).group(:id).order("count(*) desc")
  end

end
