module RestaurantsHelper
  def set_restaurant_photo(restaurant)
    restaurant_photo_url = cl_image_path(restaurant.photo.path, height: 100, width: 100, background: "black", crop: "pad") if restaurant.photo
    restaurant_photo_url.nil? ? asset_path('default_restaurant.png') : restaurant_photo_url
  end

  def set_address(restaurant)
    "#{restaurant.name}\n#{restaurant.address}\n#{restaurant.zip}\n#{restaurant.locality}"
  end
end
