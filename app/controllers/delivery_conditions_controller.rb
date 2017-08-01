class DeliveryConditionsController < ApplicationController

  def new
    @restaurant = Restaurant.find(params[:restaurant_id])
    @supplier = Supplier.find(params[:supplier_id])
    @relation = Relation.find_by(restaurant: @restaurant, supplier: @supplier)
    @delivery_condition = DeliveryCondition.new
    @delivery_condition.relation = @relation
    authorize @delivery_condition
  end

  def create
    @supplier = Supplier.find(params[:supplier_id])
    @relation = Relation.find(params["delivery_condition"]["relation_id"].to_i)
    @delivery_condition = DeliveryCondition.new
    @delivery_condition.relation = @relation
    authorize @delivery_condition

    @undelivery_days = []
    @undelivery_days << 0 if params["delivery_condition"]["sunday"] == "false"
    @undelivery_days << 1 if params["delivery_condition"]["monday"] == "false"
    @undelivery_days << 2 if params["delivery_condition"]["tuesday"] == "false"
    @undelivery_days << 3 if params["delivery_condition"]["wednesday"] == "false"
    @undelivery_days << 4 if params["delivery_condition"]["thursday"] == "false"
    @undelivery_days << 5 if params["delivery_condition"]["friday"] == "false"
    @undelivery_days << 6 if params["delivery_condition"]["saturday"] == "false"

    @delivery_condition.undelivery_days = @undelivery_days

    sunday_order = { "Dimanche" => 0, "Lundi" => 5, "Mardi" => 4, "Mercredi" => 3, "Jeudi" => 2, "Vendredi" => 1, "Samedi" => 0 }
    monday_order = { "Dimanche" => 0, "Lundi" => 0, "Mardi" => 5, "Mercredi" => 4, "Jeudi" => 3, "Vendredi" => 2, "Samedi" => 1 }
    tuesday_order = { "Dimanche" => 1, "Lundi" => 0, "Mardi" => 0, "Mercredi" => 5, "Jeudi" => 4, "Vendredi" => 3, "Samedi" => 2 }
    wednesday_order = { "Dimanche" => 2, "Lundi" => 1, "Mardi" => 0, "Mercredi" => 0, "Jeudi" => 5, "Vendredi" => 4, "Samedi" => 3 }
    thursday_order = { "Dimanche" => 3, "Lundi" => 2, "Mardi" => 1, "Mercredi" => 0, "Jeudi" => 0, "Vendredi" => 5, "Samedi" => 4 }
    friday_order = { "Dimanche" => 4, "Lundi" => 3, "Mardi" => 2, "Mercredi" => 1, "Jeudi" => 0, "Vendredi" => 0, "Samedi" => 5 }
    saturday_order = { "Dimanche" => 5, "Lundi" => 4, "Mardi" => 3, "Mercredi" => 2, "Jeudi" => 1, "Vendredi" => 0, "Samedi" => 0 }

    hour = { "11h30" => 0.5, "17h30" => 0.25, "23h30" => 0 }

    @order_deadlines = []

    if params["delivery_condition"]["sunday"] == "false"
      @order_deadlines << nil
    else
      @order_deadlines << sunday_order[params["delivery_condition"]["sunday_order_day"]] + hour[params["delivery_condition"]["sunday_order_hour"]]
    end

    if params["delivery_condition"]["monday"] == "false"
      @order_deadlines << nil
    else
      @order_deadlines << sunday_order[params["delivery_condition"]["monday_order_day"]] + hour[params["delivery_condition"]["monday_order_hour"]]
    end

    if params["delivery_condition"]["tuesday"] == "false"
      @order_deadlines << nil
    else
      @order_deadlines << sunday_order[params["delivery_condition"]["tuesday_order_day"]] + hour[params["delivery_condition"]["tuesday_order_hour"]]
    end

    if params["delivery_condition"]["wednesday"] == "false"
      @order_deadlines << nil
    else
      @order_deadlines << sunday_order[params["delivery_condition"]["wednesday_order_day"]] + hour[params["delivery_condition"]["wednesday_order_hour"]]
    end

    if params["delivery_condition"]["thursday"] == "false"
      @order_deadlines << nil
    else
      @order_deadlines << sunday_order[params["delivery_condition"]["thursday_order_day"]] + hour[params["delivery_condition"]["thursday_order_hour"]]
    end

    if params["delivery_condition"]["friday"] == "false"
      @order_deadlines << nil
    else
      @order_deadlines << sunday_order[params["delivery_condition"]["friday_order_day"]] + hour[params["delivery_condition"]["friday_order_hour"]]
    end

    if params["delivery_condition"]["saturday"] == "false"
      @order_deadlines << nil
    else
      @order_deadlines << sunday_order[params["delivery_condition"]["saturday_order_day"]] + hour[params["delivery_condition"]["saturday_order_hour"]]
    end

    @delivery_condition.order_deadlines = @order_deadlines

    @delivery_condition.order_value_min = params["delivery_condition"]["order_value_min"]
    @delivery_condition.save!
    redirect_to supplier_path(@supplier)
  end

  def edit
    @restaurant = Restaurant.find(params[:restaurant_id])
    @supplier = Supplier.find(params[:supplier_id])
    @relation = Relation.find_by(restaurant: @restaurant, supplier: @supplier)
    @delivery_condition = @relation.delivery_conditions.first
    authorize @delivery_condition
  end

  def update
    @supplier = Supplier.find(params[:supplier_id])
    @relation = Relation.find(params["delivery_condition"]["relation_id"].to_i)
    @delivery_condition = DeliveryCondition.find(params[:id])
    @delivery_condition.relation = @relation
    authorize @delivery_condition

    @undelivery_days = []
    @undelivery_days << 0 if params["delivery_condition"]["sunday"] == "false"
    @undelivery_days << 1 if params["delivery_condition"]["monday"] == "false"
    @undelivery_days << 2 if params["delivery_condition"]["tuesday"] == "false"
    @undelivery_days << 3 if params["delivery_condition"]["wednesday"] == "false"
    @undelivery_days << 4 if params["delivery_condition"]["thursday"] == "false"
    @undelivery_days << 5 if params["delivery_condition"]["friday"] == "false"
    @undelivery_days << 6 if params["delivery_condition"]["saturday"] == "false"

    @delivery_condition.undelivery_days = @undelivery_days

    sunday_order = { "Dimanche" => 0, "Lundi" => 5, "Mardi" => 4, "Mercredi" => 3, "Jeudi" => 2, "Vendredi" => 1, "Samedi" => 0 }
    monday_order = { "Dimanche" => 0, "Lundi" => 0, "Mardi" => 5, "Mercredi" => 4, "Jeudi" => 3, "Vendredi" => 2, "Samedi" => 1 }
    tuesday_order = { "Dimanche" => 1, "Lundi" => 0, "Mardi" => 0, "Mercredi" => 5, "Jeudi" => 4, "Vendredi" => 3, "Samedi" => 2 }
    wednesday_order = { "Dimanche" => 2, "Lundi" => 1, "Mardi" => 0, "Mercredi" => 0, "Jeudi" => 5, "Vendredi" => 4, "Samedi" => 3 }
    thursday_order = { "Dimanche" => 3, "Lundi" => 2, "Mardi" => 1, "Mercredi" => 0, "Jeudi" => 0, "Vendredi" => 5, "Samedi" => 4 }
    friday_order = { "Dimanche" => 4, "Lundi" => 3, "Mardi" => 2, "Mercredi" => 1, "Jeudi" => 0, "Vendredi" => 0, "Samedi" => 5 }
    saturday_order = { "Dimanche" => 5, "Lundi" => 4, "Mardi" => 3, "Mercredi" => 2, "Jeudi" => 1, "Vendredi" => 0, "Samedi" => 0 }

    hour = { "11h30" => 0.5, "17h30" => 0.25, "23h30" => 0 }

    @order_deadlines = []

    if params["delivery_condition"]["sunday"] == "false"
      @order_deadlines << nil
    else
      @order_deadlines << sunday_order[params["delivery_condition"]["sunday_order_day"]] + hour[params["delivery_condition"]["sunday_order_hour"]]
    end

    if params["delivery_condition"]["monday"] == "false"
      @order_deadlines << nil
    else
      @order_deadlines << sunday_order[params["delivery_condition"]["monday_order_day"]] + hour[params["delivery_condition"]["monday_order_hour"]]
    end

    if params["delivery_condition"]["tuesday"] == "false"
      @order_deadlines << nil
    else
      @order_deadlines << sunday_order[params["delivery_condition"]["tuesday_order_day"]] + hour[params["delivery_condition"]["tuesday_order_hour"]]
    end

    if params["delivery_condition"]["wednesday"] == "false"
      @order_deadlines << nil
    else
      @order_deadlines << sunday_order[params["delivery_condition"]["wednesday_order_day"]] + hour[params["delivery_condition"]["wednesday_order_hour"]]
    end

    if params["delivery_condition"]["thursday"] == "false"
      @order_deadlines << nil
    else
      @order_deadlines << sunday_order[params["delivery_condition"]["thursday_order_day"]] + hour[params["delivery_condition"]["thursday_order_hour"]]
    end

    if params["delivery_condition"]["friday"] == "false"
      @order_deadlines << nil
    else
      @order_deadlines << sunday_order[params["delivery_condition"]["friday_order_day"]] + hour[params["delivery_condition"]["friday_order_hour"]]
    end

    if params["delivery_condition"]["saturday"] == "false"
      @order_deadlines << nil
    else
      @order_deadlines << sunday_order[params["delivery_condition"]["saturday_order_day"]] + hour[params["delivery_condition"]["saturday_order_hour"]]
    end

    @delivery_condition.order_deadlines = @order_deadlines

    @delivery_condition.order_value_min = params["delivery_condition"]["order_value_min"]
    @delivery_condition.save!
    redirect_to supplier_path(@supplier)
  end
end
