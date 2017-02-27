module SessionsHelper

  # logs in the given user
  def log_in(user)
    # 'session' is a method distinct from the Sessions controller or session hash in sessions/new.html.erb
    # it can be treated as a hash (Section 8.2.1)
    session[:user_id] = user.id
  end

  # Returns the current logged-in user (if any).
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  # returns true if the user is logged in, false otherwise
  def logged_in?
    !current_user.nil?
  end
end
