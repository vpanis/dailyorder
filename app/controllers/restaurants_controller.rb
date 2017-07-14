class RestaurantsController < ApplicationController
  before_action :set_restaurant, only: [:show, :edit, :update, :destroy]

  def index
    @restaurants = policy_scope(Restaurant)
    @restaurants = current_user.restaurants
  end

  def show
    @profiles = @restaurant.profiles
    @suppliers = @restaurant.suppliers
  end

  def new
    @restaurant = Restaurant.new
    authorize @restaurant
  end

  def create
    @restaurant = Restaurant.new(restaurant_params)
    @restaurant = current_user.restaurants.build(restaurant_params)
    @working_relation = Profile.create(user: current_user, restaurant: @restaurant, role: "Administrateur")
    authorize @restaurant
    if @restaurant.save
      # RestaurantMailer.restaurant_creation_confirmation(current_user, @restaurant).deliver_now
      redirect_to restaurant_path(@restaurant)
    else
      render :new
    end
  end

  def edit
  end

  def update
    @restaurant.update(restaurant_params)
    redirect_to restaurant_path(@restaurant)
  end

  def destroy
    @restaurant.destroy
    redirect_to restaurants_path
  end

  private

  def set_restaurant
    @restaurant = Restaurant.find(params[:id])
    authorize @restaurant
  end

  def restaurant_params
    params.require(:restaurant).permit(:email, :name, :address, :zip, :locality, :phone_number, :siret)
  end
end
