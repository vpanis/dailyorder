namespace :order do

  desc "Sending orders"

  task send_all_noon_order: :environment do
    orders = Order.where(status: "Validée").select { |order| order.relation.delivery_conditions.first.order_deadlines[set_wday_integer(Date.today)] % order.relation.delivery_conditions.first.order_deadlines[set_wday_integer(Date.today)].floor == 0.5 }

  end

  task send_all_afternoon_order: :environment do
    orders = Order.where(status: "Validée").select { |order| order.relation.delivery_conditions.first.order_deadlines[set_wday_integer(Date.today)] % order.relation.delivery_conditions.first.order_deadlines[set_wday_integer(Date.today)].floor == 0.25 }

  end

  task send_all_midnight_order: :environment do
    orders = Order.where(status: "En cours").select { |order| order.relation.delivery_conditions.first.order_deadlines[set_wday_integer(Date.today)] % order.relation.delivery_conditions.first.order_deadlines[set_wday_integer(Date.today)].floor == 0 }

  end

end





# lib/tasks/user.rake
namespace :user do
  desc "Enriching all users with Clearbit (async)"
  task :update_all => :environment do
    users = User.all
    puts "Enqueuing update of #{users.size} users..."
    users.each do |user|
      UpdateUserJob.perform_later(user.id)
    end
    # rake task will return when all jobs are _enqueued_ (not done).
  end
end
