
class UsersController < ApplicationController
  before_filter :authenticate, :except => [:show, :new, :create]
  before_filter :correct_user, :only => [:edit, :update]
  before_filter :admin_user,   :only => :destroy
  def index
    @users = User.all
    @title = "All users"
  end
  
  def new
    @title = "Sign up"
    @user = User.new
  end
  
  def show
    @user = User.find(params[:id])
    @title = @user.name
    @microposts = @user.microposts
  end
  
  def following
    @title = "Following"
    @user = User.find(params[:id])
    @users = @user.following
    render 'show_follow'
  end
  
  def followers
    @title = "Followers"
    @user = User.find(params[:id])
    @users = @user.followers
    render 'show_follow'
  end
  def create
    @user = User.new(user_params)
    if @user.save
      # flash[:success] = "Welcome to the Sample App!"
      # redirect_to user_path(@user)
      sign_in @user
      redirect_to @user, :flash => { :success => "Welcome to the Sample App!"}
    else
      @title = "Sign up"
      render "new"
    end
  end

  def edit
    @title = "Edit user"
  end
  
  def update
    if @user.update_attributes(user_params)
      redirect_to @user, :flash => { :success => "Profile updated"}
    else
      @title = "Edit user"
      render 'edit'
    end
  end
  
  def destroy
    User.find(params[:id]).destroy
    redirect_to users_path, :flash => {:success => "User destroyed."}
  end
  
  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
  
  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_path) unless @user == current_user
  end
  
  def admin_user
    user = User.find(params[:id])
    redirect_to(root_path) unless (current_user.admin? && ! current_user?(user))
  end
end
