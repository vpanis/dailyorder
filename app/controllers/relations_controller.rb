class RelationsController < ApplicationController

  def index
    @restaurant = Restaurant.find(params[:restaurant_id])
    @suppliers = @restaurant.suppliers
    @relations = policy_scope(Relation)
    @relations = Relation.where(restaurant: @restaurant)
  end

  def create
    raise
    redirect_to restaurant_path(@restaurant)
  end
end
