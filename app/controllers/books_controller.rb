class BooksController < ApplicationController
   before_action :require_librarian, except: [:issue, :index, :show ,:new ,:create , :update ,:delete]
    def show
        @book = Book.find(params[:id])
    end
    
    def index
        @books = Book.all
    end
    def new
        @book = Book.new
     end
  
    def book_params
        params.require(:books).permit(:title, :number_Of_units, :description)
    end

    def issue
      @book = Book.find(params[:id])
    end
  
    def create
        @book = Book.new(book_params)
  
        if @book.save
            flash[:notice] = "Book #{book.title} was successfully added in library"
           redirect_to :action => 'index'
        else
           render :action => 'new'
        end
     end
     
     def edit
        @book = Book.find(params[:id])
     end
     
     def book_param
        params.require(:book).permit(:title, :number_Of_units, :description)
     end
     
     def update
        @book = Book.find(params[:id])
        
        if @book.update_attributes(book_param)
            flash[:notice] = "Book #{book.title} was successfully updated in Library"
           redirect_to :action => 'show', :id => @book
        else
           render :action => 'edit'
        end
     end
     
     def delete
        Book.find(params[:id]).destroy
        redirect_to :action => 'index'
     end
     private
     def require_librarian
      if !(logged_in? && current_user.librarian?)
        flash[:alert] = "Only Libraian can perform that action"
        redirect_to root_path
      end
    end
end
