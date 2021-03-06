class UsersController < ApplicationController
  before_action :logged_in_user,    only: [:index, :edit, :update, :destroy]
  before_action :correct_user,      only: [:edit, :update]
  before_action :admin_user,        only: :destroy


  def index
    # @users = User.all
    # @users = User.paginate(page: params[:page])

    # exercise 11.3.3.2
    @users = User.where(activated: true).paginate(page: params[:page])
  end

  def new
    # debugger
    # value of @user in /users/new is nil (exercise 7.1.3)
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      # handle a successful save
      # ch11
      @user.send_activation_email
      flash[:info] = "Please check your email to activate your account."
      redirect_to root_url

      # old code for when user gets immediate access to account w/o email
      # log_in(@user)
      # flash[:success] = "Welcome to Sample App!"
      # redirect_to @user # also works: redirect_to user_url(@user); rails understands the former [magic]
    else
      render 'new'
    end
  end

  def show
    @user = User.find(params[:id])
    # debugger
    redirect_to root_url and return unless @user.activated?
  end

  def edit
    # @user = User.find(params[:id])
  end

  def update
    # @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      # handle a successful update
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_path
  end

  # private section: start
  private
    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end

    # before filters

    # confirms a logged-in user
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end

    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
  # private section: end
end
