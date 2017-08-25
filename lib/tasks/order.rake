namespace :order do

  desc "Sending orders"

  task send: :environment do

    orders = []
    suppliers =[]

    Order.where(status: "Validée").each do |order|
      if order.delivery_date.strftime("%A").downcase == "sunday"
        w_day = 0
      elsif order.delivery_date.strftime("%A").downcase == "monday"
        w_day = 1
      elsif order.delivery_date.strftime("%A").downcase == "tuesday"
        w_day = 2
      elsif order.delivery_date.strftime("%A").downcase == "wednesday"
        w_day = 3
      elsif order.delivery_date.strftime("%A").downcase == "thursday"
        w_day = 4
      elsif order.delivery_date.strftime("%A").downcase == "friday"
        w_day = 5
      elsif order.delivery_date.strftime("%A").downcase == "saturday"
        w_day = 6
      end
      if order.delivery_date - order.relation.delivery_conditions.first.order_deadlines[w_day].days < DateTime.now
        order.status = "Envoyée"
        order.save
        orders << order
        suppliers << order.supplier
      end
    end

    suppliers.each do |supplier|
      document = Document.create(
        title: "Relevé de commandes du #{DateTime.now.strftime("%d/%m/%Y")}",
        document_type: "Relevé de commandes",
        supplier: supplier)
      supplier_orders = orders.select{ |order| order.supplier == supplier }
      supplier_orders = supplier_orders.map! { |supplier_order| supplier_order.id }
      OrderMailer.send_orders(supplier.id, supplier_orders, document.id).deliver_now
    end
  end
end
