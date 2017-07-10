class RestaurantsController < ApplicationController
  before_action :set_restaurant, only: [:show, :edit, :update, :destroy]

  def index
    @restaurants = policy_scope(Restaurant)
    @restaurants = current_user.restaurants
  end

  def show
  end

  def new
    @restaurant = Restaurant.new
    authorize @restaurant
  end

  def create
    @restaurant = Restaurant.new(restaurant_params)
    @restaurant = current_user.restaurants.build(restaurant_params)
    authorize @restaurant
    if @restaurant.save
      RestaurantMailer.restaurant_creation_confirmation(current_user, @restaurant).deliver_now
      redirect_to restaurants_path
    else
      render :new
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def set_restaurant
    @restaurant = Restaurant.find(params[:id])
  end

  def restaurant_params
    params.require(:restaurant).permit(:email, :name, :address, :phone_number, :siret)
  end

end
