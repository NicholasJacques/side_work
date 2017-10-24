class AccountActivationsController < ApplicationController
  def edit
    user = User.find_by(email: params[:email])
    if user && !user.activated && user.authenticated?(params[:id])
      user.activate
      log_in(user)
      flash[:success] = 'Thank you for verifying your email'
      redirect_to user.profile
    else
      flash[:danger] = 'Invalid activation email'
      redirect_to root_path
    end
  end
end
