class ProductsController < ApplicationController

  def index
    @supplier = Supplier.find(params[:supplier_id])
    @products = policy_scope(Product)
    @products = @supplier.products
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
