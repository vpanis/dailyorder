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
    @supplier = Supplier.find(params[:supplier_id])
    @product = Product.new
    authorize @product

    @products = policy_scope(Product)
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end

  def import
    @supplier = Supplier.find(params[:supplier_id])
    @product = Product.new
    authorize @product
    Product.import(params[:file], @supplier)
    redirect_to supplier_path(@supplier), notice: "Products imported."
  end

  private

  def product_params
    params.require(:relation).permit(:restaurant, :provider, :order_value_min)
  end
end
