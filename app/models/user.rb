class User < ApplicationRecord
  include PgSearch
  pg_search_scope :search_user,
                  against: [ :email, :first_name, :last_name ],
                  using: { tsearch: { prefix: true } },
                  ignoring: :accents

  # after_create :send_welcome_email
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:facebook]

  has_many :profiles
  has_many :restaurants, through: :profiles
  has_many :relations, through: :restaurants
  has_many :orders

  validates :email, presence: true
  validates :email, uniqueness: true

  has_attachment :photo

  def self.find_for_facebook_oauth(auth)
    user_params = auth.slice(:supplier, :uid)
    user_params.merge! auth.info.slice(:email, :first_name, :last_name)
    user_params[:facebook_picture_url] = auth.info.image
    user_params[:token] = auth.credentials.token
    user_params[:token_expiry] = Time.at(auth.credentials.expires_at)
    user_params = user_params.to_h

    user = User.find_by(provider: auth.supplier, uid: auth.uid)
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

  private

  def send_welcome_email
    UserMailer.welcome(self.id).deliver_later
  end
end
