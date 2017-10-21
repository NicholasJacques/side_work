module SessionsHelper
  def current_user
    @current_user ||= Contractor.find_by(id: session[:user_id]) if session[:user_id]
  end

  def log_in(user)
    session[:user_id] = user.id
    flash_welcome_message(user)
    redirect_to user.profile
  end

  def failed_log_in
    flash.now[:danger] = 'This Email/Password combination was not found.'
    render :new
  end

  def flash_welcome_message(user)
    if user.contractor?
      flash[:success] = "Welcome, #{user.profile.first_name}."
    end
  end
end
