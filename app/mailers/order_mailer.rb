class OrderMailer < ApplicationMailer
  def send_noon_order(user_id, restaurant_id)
    @user = User.find(user_id)
    @restaurant = Restaurant.find(restaurant_id)

    mail(
      to:       @user.email,
      subject:  "Le restaurant #{@restaurant.name} a été crée !"
    )
  end
end
