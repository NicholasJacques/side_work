class SessionsController < ApplicationController
  def new
  end

  def create
    @user = Contractor.find_by(email: params[:session][:email].downcase)
    if @user && @user.authenticate(params[:session][:password])
      session[:user_id] = @user.id
      flash[:success] = "Welcome, #{current_user.first_name}."
      redirect_to @user
    else
      flash.now[:danger] = 'This Email/Password combination was not found.'
      render :new
    end
  end
end
