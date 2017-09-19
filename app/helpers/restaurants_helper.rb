module RestaurantsHelper
  def set_restaurant_photo(restaurant)
    avatar_url = restaurant.photo
    avatar_url = cl_image_path(restaurant.photo.public_id, height: 100, width: 100, crop: :fill) if avatar_url.nil? && user.photo
    avatar_url.nil? ? asset_path('default_restaurant.png') : avatar_url
  end

  def set_address(restaurant)
    "#{restaurant.name}\n#{restaurant.address}\n#{restaurant.zip}\n#{restaurant.locality}"
  end
end
