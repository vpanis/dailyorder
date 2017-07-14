module RestaurantsHelper
  def set_address(restaurant)
    "#{restaurant.name}\n#{restaurant.address}\n#{restaurant.zip}\n#{restaurant.locality}"
  end
end
