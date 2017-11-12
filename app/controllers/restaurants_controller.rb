class RestaurantsController < ApplicationController
  def new
    @restaurant = Restaurant.new
    @restaurant.user = User.new
  end

  def create
    @restaurant = Restaurant.new(restaurant_params)
    if @restaurant.save
      @restaurant.send_activation_email
      log_in(@restaurant.user)
      flash[:info] = 'Please check your email to continue setting up your account'
      redirect_to @restaurant
    else
      render 'new'
    end
  end

  def show
  end

  def edit
  end

  private

  def restaurant_params
    params.require(:restaurant).permit(:name,
                                       user_attributes: [:email,
                                                         :password,
                                                         :password_confirmation])
  end
end
