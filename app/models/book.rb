class Book < ApplicationRecord
    has_many :user_books
    has_many :users, through: :user_books
    validates :title, presence: true, length: { minimum: 2, maximum: 100 }
    def self.check_db(book_title)
        where(title: book_title).first
      end
end
