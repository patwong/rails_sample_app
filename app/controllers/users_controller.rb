class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update]

  def new
    # debugger
    # value of @user in /users/new is nil (exercise 7.1.3)
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      # handle a succesful save
      log_in(@user)
      flash[:success] = "Welcome to Sample App!"
      redirect_to @user # also works: redirect_to user_url(@user); rails understands the former [magic]
    else
      render 'new'
    end
  end

  def show
    @user = User.find(params[:id])
    # debugger
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      # handle a successful update
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
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
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end
  # private section: end
end
