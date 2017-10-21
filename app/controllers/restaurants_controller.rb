class RestaurantsController < ApplicationController
  def new
    @restaurant = Restaurant.new
    @restaurant.user = User.new
  end

  def create
    @restaurant = Restaurant.new(restaurant_params)
    if @restaurant.save
      log_in(@restaurant.user)
      flash[:success] = 'Welcome to SideWork'
      redirect_to @restaurant
    else
      render 'new'
    end
  end

  def show
  end

  private

  def restaurant_params
    params.require(:restaurant).permit(:name,
                                       user_attributes: [:email,
                                                         :password,
                                                         :password_confirmation])
  end
end
