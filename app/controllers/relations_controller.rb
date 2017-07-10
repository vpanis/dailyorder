class RelationsController < ApplicationController

  def index
    @restaurant = Restaurant.find(params[:restaurant_id])
    @suppliers = @restaurant.suppliers
    @relations = policy_scope(Relation)
    @relations = Relation.where(restaurant: @restaurant)
  end

  def show
    @restaurant = Restaurant.find(params[:restaurant_id])
    @relation = Relation.find(params[:id])
    @supplier = @relation.supplier
    @products = @relation.products

    @favorite_products = []
    @relation.favorites.each do |favorite|
      @favorite_products << favorite.product
    end

    @order_lines =[]
    @order_lines_promotions =[]
    @order_lines_favorites =[]

    @products.each do |product|
      a = instance_variable_set("@order_line_#{product.id}", OrderLine.new)
      a.product = product
      if @favorite_products.include?(product)
        @order_lines_favorites << a
      end
      if product.is_discount
        @order_lines_promotions << a
      end
      @order_lines << a
    end

    @favorites = @relation.favorites
    @promotions = @products.where(is_discount: true)
    authorize @relation
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
