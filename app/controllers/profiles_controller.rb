class ProfilesController < ApplicationController
  before_action :set_profile, only: [:edit, :update]

  def index
    @profiles = policy_scope(Profile)
    @restaurant = Restaurant.find(params[:restaurant_id])
    authorize @restaurant
    if params[:query]
      @users = User.search_user(params[:query])
    else
      @users = []
    end
  end

  def new
    @user = User.find(params[:user_id])
    @restaurant = Restaurant.find(params[:restaurant_id])
    @profile = Profile.new
    authorize @profile
  end

  def create
    @user = User.find(params[:profile][:user_id])
    @restaurant = Restaurant.find(params[:restaurant_id])
    @profile = Profile.new()
    authorize @profile
    @profile.restaurant = @restaurant
    @profile.user = @user
    @profile.role = params[:profile][:role]
    @profile.save
    redirect_to restaurant_path(@restaurant)
  end

  def edit
  end

  def update
    @profile.update(profile_params)
    redirect_to restaurant_path(@restaurant)
  end

  private

  def set_profile
    @profile = Profile.find(params[:id])
    @restaurant = Restaurant.find(params[:restaurant_id])
    authorize @profile
  end

  def profile_params
    params.require(:profile).permit(:role)
  end
end
