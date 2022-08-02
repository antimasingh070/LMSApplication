class UsersController < ApplicationController
    before_action :set_user, only: [:show, :edit, :update, :destroy]
    before_action :require_user, only: [:edit, :update]
    before_action :require_same_user, only: [:edit, :update, :destroy]
  
    def show
      @books = User.all
    end
  
    def index
      @users = User.all
    end
  
    def new
      @user = User.new
    end
  
    def edit
    end
  
    def update
      if @user.update(user_params)
        flash[:notice] = "Your account information was successfully updated"
        redirect_to @user
      else
        render 'edit'
      end
    end
  
    def create
      @user = User.new(user_params)
      if @user.save
        session[:user_id] = @user.id
        flash[:notice] = "Welcome to the LMS App #{@user.first_name}, you have successfully signed up"
        redirect_to books_path
      else
        render 'new'
      end
    end
  
    def destroy
      @user.destroy
      session[:user_id] = nil if @user == current_user
      flash[:notice] = "Account and all associated books successfully deleted"
      redirect_to books_path
    end
  
    private
    def user_params
      params.require(:user).permit(:first_name, :email, :password)
    end
  
    def set_user
      @user = User.find(params[:id])
    end
  
    def require_same_user
      if current_user != @user && !current_user.librarian?
        flash[:alert] = "You can only edit or delete your own account"
        redirect_to @user
      end
    end
end
