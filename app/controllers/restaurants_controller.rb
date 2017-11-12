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
      flash[:success] = 'Welcome to SideWork'
      redirect_to @restaurant
    else
      render 'new'
    end
  end

  def show
  end

  def edit
    @restaurant = Restaurant.find(params[:id])
  end

  def update
    @restaurant = Restaurant.find(params[:id])
    if @restaurant.update_attributes(restaurant_params)
      @restaurant.complete_account
      redirect_to @restaurant
    else
      render 'edit'
    end
  end

  private

  def restaurant_params
    params.require(:restaurant).permit(:name,
                                       :manager,
                                       user_attributes: [:id,
                                                         :email,
                                                         :password,
                                                         :password_confirmation,
                                                         address_attributes: [:street,
                                                                              :id,
                                                                              :street2,
                                                                              :city,
                                                                              :state,
                                                                              :zip_code]])
  end
end
