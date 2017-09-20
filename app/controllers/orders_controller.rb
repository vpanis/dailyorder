class OrdersController < ApplicationController

  def index_pending
    @restaurant = Restaurant.find(params["restaurant_id"])
    @orders = policy_scope(Order)
    authorize Order
    @orders = @restaurant.orders.sort_by { |order| order.created_at }.reverse!
    @orders_pending = @orders.select { |order| order.status == "En cours" }
  end

  def index_validated
    @restaurant = Restaurant.find(params["restaurant_id"])
    @orders = policy_scope(Order)
    authorize Order
    @orders = @restaurant.orders.sort_by { |order| order.created_at }.reverse!
    @orders_validated = @orders.select { |order| order.status == "Validée" }
  end

  def index_sent
    @restaurant = Restaurant.find(params["restaurant_id"])
    @orders = policy_scope(Order)
    authorize Order
    @orders = @restaurant.orders.sort_by { |order| order.created_at }.reverse!
    @orders_sent = @orders.select { |order| order.status == "Envoyée" }
  end

  def new
    @date = DateTime.now
    @restaurant = Restaurant.find(params[:restaurant_id])
    @supplier = Supplier.find(params[:supplier_id])
    @relation = Relation.find_by(restaurant: @restaurant, supplier: @supplier)
    @products = @relation.products
    @days_of_delivery = []

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
      if product.is_discount && !@favorite_products.include?(product)
        @order_lines_promotions << a
      end
      if @favorite_products.include?(product)
        @order_lines_favorites << a
      end
      if !@favorite_products.include?(product) && !product.is_discount
        @order_lines << a
      end
    end

    @order = Order.new
    authorize @order
  end

  def create
    @restaurant = Restaurant.find(params["restaurant_id"])
    @order = Order.new
    authorize @order
    @order.relation = Relation.find(params["relation_id"].to_i)
    @order.user = current_user

    if params["delivery_date"] == ""
      @order.delivery_date = nil
      @order.status = "En cours"
    else params["delivery_date"].to_datetime > DateTime.now
      @order.delivery_date = params["delivery_date"].to_datetime
      @order.status = "Validée"
    end

    @order_lines = params["order_lines"].to_a.map { |ol| ol.to_a }

    @order_lines.each do |order_line|
      if order_line[1][1].to_f != 0
        a = OrderLine.new
        a.order = @order
        a.product = Product.find(order_line[0][1].to_i)
        a.quantity = order_line[1][1].to_f
        a.save!
      end
    end

    if @order.order_lines.first.nil?
      redirect_to restaurant_index_validated_path(@restaurant)
    else
      @order.save!
      @document = Document.create(
        title: "Commande #{@order.supplier.name} effectuée le #{@order.created_at} pour le #{@order.delivery_date}",
        document_type: "Bon de commande",
        relation: Relation.find(params["relation_id"].to_i),
        restaurant: @order.restaurant,
        supplier: @order.supplier,
        order: @order)
      if @order.delivery_date.nil?
        redirect_to restaurant_index_pending_path(@restaurant)
      else
        redirect_to restaurant_index_validated_path(@restaurant)
      end
    end
  end

  def edit
    @date = DateTime.now
    @restaurant = Restaurant.find(params[:restaurant_id])
    @order = Order.find(params[:id])
    authorize @order
    @relation = @order.relation
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
      if OrderLine.find_by(product: product, order: @order).nil?
        a = OrderLine.new
        a.product = product
        a.order = @order
        if product.is_discount && !@favorite_products.include?(product)
          @order_lines_promotions << a
        elsif @favorite_products.include?(product)
          @order_lines_favorites << a
        else
          @order_lines << a
        end
      else
        a = OrderLine.find_by(product: product, order: @order)
        if product.is_discount && !@favorite_products.include?(product)
          @order_lines_promotions << a
        elsif @favorite_products.include?(product)
          @order_lines_favorites << a
        else !@favorite_products.include?(product) && !product.is_discount
          @order_lines << a
        end
      end
    end
  end

  def update
    @date = DateTime.now
    @restaurant = Restaurant.find(params["restaurant_id"])
    @order = Order.find(params["id"])
    authorize @order

    @relation = @order.relation

    @order.user = current_user

    @order_lines = []
    if params["order"]
      if !params["order"]["promotions"].nil?
        params["order"]["promotions"].to_a.each do |a|
          @order_lines << a[1].to_a
        end
      end
      if !params["order"]["favorites"].nil?
        params["order"]["favorites"].to_a.each do |a|
          @order_lines << a[1].to_a
        end
      end
      if !params["order"]["others"].nil?
        params["order"]["others"].to_a.each do |a|
          @order_lines << a[1].to_a
        end
      end
    elsif params["order_lines"]
      params["order_lines"].to_a.each do |a|
        @order_lines << a[1].to_a
      end
    end

    @order_lines.each do |order_line|
      if !OrderLine.find_by(product_id: order_line[0][1].to_i, order: @order).nil?
        if order_line[1][1].to_f != 0
          a = OrderLine.find_by(product_id: order_line[0][1].to_i, order: @order)
          a.quantity = order_line[1][1].to_f
          a.save!
        else
          a = OrderLine.find_by(product_id: order_line[0][1].to_i, order: @order)
          a.destroy!
        end
      else
        if order_line[1][1].to_f != 0
          a = OrderLine.new
          a.order = @order
          a.product = Product.find(order_line[0][1].to_i)
          a.quantity = order_line[1][1].to_f
          a.save!
        end
      end
    end



    if !params["delivery_date"].nil? && !params["delivery_date"].to_datetime.nil? && params["delivery_date"].to_datetime > DateTime.now
      @order.delivery_date = params["delivery_date"].to_datetime
      @order.status = "Validée"
    else
      @order.delivery_date = nil
      @order.status = "En cours"
    end

    if @order.order_lines.first.nil?
      @order.destroy!
      redirect_to restaurant_index_validated_path(@restaurant)
    elsif @order.delivery_date.nil?
      @order.save!
      redirect_to restaurant_index_pending_path(@restaurant)
    else
      @document = Document.find_by(order: @order, document_type: "Bon de commande")
      @document.update(
        title: "Commande #{@order.relation.supplier.name} effectuée le #{@order.created_at} pour le #{@order.delivery_date}",
        document_type: "Bon de commande",
        relation: @relation,
        order: @order)
      @order.save!
      redirect_to restaurant_index_validated_path(@restaurant)
    end
  end

  def destroy
    @restaurant = Restaurant.find(params["restaurant_id"])
    @order = Order.find(params["id"])
    authorize @order
    if @order.status == "En cours"
      @order.destroy
      redirect_to restaurant_index_pending_path(@restaurant)
    elsif @order.status == "Validée"
      @order.destroy
      redirect_to restaurant_index_validated_path(@restaurant)
    elsif @order.status == "Envoyée"
      @order.destroy
      redirect_to restaurant_index_sent_path(@restaurant)
    end
  end

  # private

  # def order_lines_promotions_params
  #   params.require(:order_lines_promotions).permit!.each do |k,v|
  #     v.permit(:product_id, :quantity)
  #   end
  # end

  # def order_lines_favorites_params
  #   params.require(:order_lines_favorites).permit!.each do |k,v|
  #     v.permit(:product_id, :quantity)
  #   end
  # end

  # def order_lines_params
  #   params.require(:order_lines).permit!.each do |k,v|
  #     v.permit(:product_id, :quantity)
  #   end
  # end

  # def delivery_date_params
  #   params.require(:delivery_date)
  # end

end
