module AccountActivationsHelper
  def check_verification
    if logged_in? && !current_user.activated?
      flash.now[:warning] = 'Please check your email to verify your account'
    end
  end

  def check_account_completion
    if logged_in? && !current_user.account_completed? && current_user.activated?
      complete = view_context.link_to('complete', edit_polymorphic_path(current_user.profile))
      flash.now[:warning] = "Please #{complete} your account to begin using SideWork.".html_safe
    end
  end
end

