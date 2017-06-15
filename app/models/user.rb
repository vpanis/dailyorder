class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:facebook]

  belongs_to :restaurant, optional: true
  belongs_to :provider, optional: true

  validates :email, :first_name, :last_name, :phone_number, presence: true
  validates :position, inclusion: { in: ["Chef de cuisine", "Second de cuisine", "Responsable de salle", "Directeur de salle", "Patron", ""] }
  validates :profile, inclusion: { in: ["Cuisine", "Salle", "Patron", ""] }

  validate :is_restaurant, :is_provider

  has_attachment :photo

  def self.find_for_facebook_oauth(auth)
    user_params = auth.slice(:provider, :uid)
    user_params.merge! auth.info.slice(:email, :first_name, :last_name)
    user_params[:facebook_picture_url] = auth.info.image
    user_params[:token] = auth.credentials.token
    user_params[:token_expiry] = Time.at(auth.credentials.expires_at)
    user_params = user_params.to_h

    user = User.find_by(provider: auth.provider, uid: auth.uid)
    user ||= User.find_by(email: auth.info.email) # User did a regular sign up in the past.
    if user
      user.update(user_params)
    else
      user = User.new(user_params)
      user.password = Devise.friendly_token[0,20]  # Fake password for validation
      user.save
    end

    return user
  end

  def is_restaurant
    if !restaurant.nil? and !provider.nil?
      errors.add(:provider, "has to be nil")
    end
  end

  def is_provider
    if !provider.nil? and !restaurant.nil?
      errors.add(:restaurant, "has to be nil")
    end
  end
end
