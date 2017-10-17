module SessionsHelper
  def current_user
    @current_user ||= Contractor.find_by(id: session[:user_id]) if session[:user_id]
  end
end
