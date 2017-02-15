class UsersController < ApplicationController

  def new
    # debugger
    # value of @user in /users/new is nil (exercise 7.1.3)
    @user = User.new
  end

  def create
    @user = User.new(user_params)   # not the final implementation
    if @user.save
      # handle a succesful save
    else
      render 'new'
    end
  end

  def show
    @user = User.find(params[:id])
    # debugger
  end

  private
    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end
  # private section
end
