module AccountActivationsHelper
  def check_verification
    if logged_in? && !current_user.activated?
      flash.now[:warning] = 'Please check your email to verify your account'
    end
  end
end
