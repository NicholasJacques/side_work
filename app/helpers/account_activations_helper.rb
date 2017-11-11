module AccountActivationsHelper
  def check_verification
    if logged_in? && !current_user.activated?
      flash.now[:warning] = 'Please check your email to verify your account'
    end
  end

  def check_account_completion
    if logged_in? && !current_user.account_completed? && current_user.activated?
      flash.now[:warning] = 'Please complete your account to begin using SideWork.'
    end
  end
end
