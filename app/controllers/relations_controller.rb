class RelationsController < ApplicationController

  def index
    @restaurant = Restaurant.find(params[:restaurant_id])
    @suppliers = @restaurant.suppliers.select { |supplier| !supplier.delivery_conditions.first.nil? }
    @relations = policy_scope(Relation)
    @relations = Relation.where(restaurant: @restaurant).select { |relation| !relation.supplier.delivery_conditions.first.nil? }
  end

  def new
    @restaurant = Restaurant.find(params[:restaurant_id])
    authorize @restaurant
    if params[:query].present?
      @suppliers = Supplier.search_supplier(params[:query])
    else
      @suppliers = []
    end
  end

  def create
    @restaurant = Restaurant.find(params[:restaurant_id])
    @supplier = Supplier.find(params[:supplier_id])
    @relation = Relation.new
    @relation.restaurant = @restaurant
    @relation.supplier = @supplier
    authorize @relation
    @relation.save!
    redirect_to restaurant_path(@restaurant)
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
