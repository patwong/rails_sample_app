class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    # debugger
    # this should throw an exception but instead rails treats this as 'false' and moves to the else condition
    if user && user.authenticate(params[:session][:password])
      # log in the user
    else
      flash.now[:danger] = "Invalid email/password combination"
      render 'new'
    end
  end

  def destroy
  end
end
