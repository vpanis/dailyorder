class OrdersController < ApplicationController

  def index
    @restaurant = Restaurant.find(params["restaurant_id"])
    @orders = policy_scope(Order)
    @orders = @restaurant.orders.sort_by { |order| order.delivery_date ? order.delivery_date : order.created_at }.reverse!
    @orders_pending = @orders.select { |order| order.status == "En cours" }
    @orders_validated = @orders.select { |order| order.status == "Validée" }
    @orders_sent = @orders.select { |order| order.status == "Envoyée" }
  end

  def show
  end

  def create
    @restaurant = Restaurant.find(params["restaurant_id"])
    @order = Order.new
    @order.relation = Relation.find(params["relation_id"].to_i)
    @order.user = current_user

    if params["delivery_date"] == ""
      @order.status = "En cours"
    else params["delivery_date"].to_datetime >= DateTime.now + 1
      @order.delivery_date = params["delivery_date"].to_datetime
      @order.status = "Validée"
    end

    @order_lines = []
    @order_lines << params[:order_lines_promotions] if !params[:order_lines_promotions].nil?
    @order_lines << params[:order_lines_favorites] if !params[:order_lines_favorites].nil?
    @order_lines << params[:order_lines] if !params[:order_lines].nil?

    @order_lines.each do |order_line|
      if order_line.first["quantity"].to_f != 0
        a = OrderLine.new
        a.order = @order
        a.product = Product.find(order_line.first["product_id"].to_i)
        a.quantity = order_line.first["quantity"].to_f
        authorize a
        a.save!
      end
    end

    authorize @order
    if @order.order_lines.first.nil?
      redirect_to restaurant_orders_path(@restaurant)
    else
      @document = Document.create(
        title: "Commande #{@order.relation.supplier.name} effectuée le #{@order.created_at} pour le #{@order.delivery_date}",
        document_type: "Bon de commande",
        order: @order)
      @order.save!
      redirect_to restaurant_orders_path(@restaurant)
    end
  end

  def update
    @restaurant = Restaurant.find(params["restaurant_id"])
    @order = Order.find(params["id"])
    params["@orders.order_lines"].to_a.each do |order_line|
      if !order_line[1].nil?
        a = OrderLine.find(order_line.first.to_i)
        a.quantity = order_line[1]["quantity"].to_f
        authorize a
        a.save
      end
    end
    if params["submit"] == "Valider"
      if params["delivery_date"] == ""
        @order.status = "En cours"
      else params["delivery_date"].to_datetime >= DateTime.now + 1
        @order.delivery_date = params["delivery_date"].to_datetime
        @order.status = "Validée"
      end
    end

    authorize @order
    @order.save
    redirect_to restaurant_orders_path(@restaurant)
  end

  def destroy
    @restaurant = Restaurant.find(params["restaurant_id"])
    @order = Order.find(params["id"])
    authorize @order
    @order.destroy
    redirect_to restaurant_orders_path(@restaurant)
  end

end
