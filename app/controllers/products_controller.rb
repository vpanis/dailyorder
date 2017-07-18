class ProductsController < ApplicationController

  def index
    @products = policy_scope(Product)
    if params[:query].present?
      @products = Product.search_product(params[:query])
    else
      @products = []
    end
  end

  def show
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

  private

  def product_params
    params.require(:relation).permit(:restaurant, :provider, :order_value_min)
  end
end
