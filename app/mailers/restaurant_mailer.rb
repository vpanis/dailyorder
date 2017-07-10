class RestaurantMailer < ApplicationMailer
  def restaurant_creation_confirmation(user, restaurant)
    @restaurant = restaurant
    @user = user

    mail(
      to:       @user.email,
      subject:  "Le restaurant #{@restaurant.name} a été crée !"
    )
  end
end
