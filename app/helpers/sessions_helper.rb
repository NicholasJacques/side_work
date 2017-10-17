module SessionsHelper
  def current_user
    @current_user ||= Contractor.find_by(id: session[:user_id]) if session[:user_id]
  end

  def log_in(user)
    session[:user_id] = user.id
    flash[:success] = "Welcome, #{user.first_name}."
    redirect_to user
  end

  def failed_log_in
    flash.now[:danger] = 'This Email/Password combination was not found.'
    render :new
  end
end
