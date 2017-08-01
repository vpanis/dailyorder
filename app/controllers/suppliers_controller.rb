class SuppliersController < ApplicationController
  before_action :set_supplier, only: [:show, :edit, :update, :destroy]

  def index
    @suppliers = policy_scope(Supplier)
    @suppliers = current_user.suppliers
    @profiles = current_user.profiles.select { |profile| profile.restaurant.nil? }
  end

  def show
    @profiles = @supplier.profiles
    @restaurants = @supplier.restaurants
  end

  def new
    @supplier = Supplier.new
    authorize @supplier
  end

  def create
    @supplier = Supplier.create(supplier_params)
    authorize @supplier
    redirect_to supplier_path(@supplier)
  end

  def edit
  end

  def update
    @supplier.update(supplier_params)
    redirect_to supplier_path(@supplier)
  end

  def destroy
    @supplier.destroy
    redirect_to suppliers_path
  end

  private

  def set_supplier
    @supplier = Supplier.find(params[:id])
    authorize @supplier
  end

  def supplier_params
    params.require(:supplier).permit(:email, :name, :address, :zip, :locality, :phone_number, :sector, :siret)
  end
end
