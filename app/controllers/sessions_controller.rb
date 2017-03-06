class SessionsController < ApplicationController
  def new
  end

  def create
    # by turning 'user' into an instance variable (@user), we can use the method 'assigns'
    # in an integration test to check @user's attributes (exercise 9.3.1.1)
    @user = User.find_by(email: params[:session][:email].downcase)
    # debugger
    # the second part of logical-AND is ignored since 'user' is nil - if-statement is evaluated to be false
    # otherwise, an exception will be thrown and the if-statement fails
    # i.e. shortcircuiting
    if @user && @user.authenticate(params[:session][:password])
      log_in @user           # parenthesis not needed for method calls
      params[:session][:remember_me] == '1' ? remember(@user) : forget(@user)
      redirect_to @user
    else
      flash.now[:danger] = "Invalid email/password combination"
      render 'new'
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_path
  end
end
