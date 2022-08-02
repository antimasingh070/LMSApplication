class UserBooksController < ApplicationController
    def create
        book = Book.check_db(params[:book_title]) 
        @user_book = UserBook.create(user: current_user, book: book)
        flash[:notice] = "Book #{stock.name} was successfully added to your library"
        redirect_to root_path
      end
    
      def destroy
        book = Book.find(params[:id])
        user_book = UserBook.where(user_id: current_user.id, book_id: book.id).first
        user_book.destroy
        flash[:notice] = "#{book.title} was successfully removed from library"
        redirect_to root_path
      end
end
