module UsersHelper
  def set_user_photo(user)
    avatar_url = user.facebook_picture_url
    avatar_url = cl_image_path(user.photo.public_id, height: 100, width: 100, crop: :fill) if avatar_url.nil? && user.photo
    avatar_url.nil? ? asset_path('default_avatar.png') : avatar_url
  end

  def set_username(user)
    user.first_name.nil? ? user.email : user.first_name
  end
end
