class ProductsController < ApplicationController

  def index
    @products = policy_scope(Product)
    if params[:query].present?
      @products = Product.search(params[:query],
                                     fields: [:name],
                                     page: params[:page])
    else
      @products = Product.all.page params[:page]
    end
  end

  def autocomplete
    render json: Product.search(params[:query],
                 autocomplete: true,
                 fields: [:name],
                 limit: 10).map { |product|
                   product.name
                 }
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
