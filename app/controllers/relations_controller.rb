class RelationsController < ApplicationController

  def index
    @restaurant = Restaurant.find(params[:restaurant_id])
    @suppliers = @restaurant.suppliers
    @relations = policy_scope(Relation)
    @relations = Relation.where(restaurant: @restaurant)
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
