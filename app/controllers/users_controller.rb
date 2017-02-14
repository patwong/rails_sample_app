class UsersController < ApplicationController

  def new
    # debugger
    # value of @user in /users/new is nil (exercise 7.1.3)
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
    # debugger
  end
end
