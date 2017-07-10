class User < ApplicationRecord
  after_create :send_welcome_email
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:facebook]

  belongs_to :group, optional: true
  belongs_to :supplier, optional: true

  has_many :working_relations
  has_many :restaurants, through: :group
  has_many :relations, through: :restaurants
  has_many :orders

  validates :email, :first_name, :last_name, presence: true
  validates :email, uniqueness: true
  validates :position, inclusion: { in: ["Chef de cuisine", "Second de cuisine", "Responsable de salle", "Directeur de salle", "Dirigeant d'un restaurant", "Dirigeant de plusieurs restaurants", ""] }
  validates :profile, inclusion: { in: ["Cuisine", "Salle", "Restaurant", "Groupe", ""] }

  validate :is_restaurant, :is_supplier

  has_attachment :photo

  def self.find_for_facebook_oauth(auth)
    user_params = auth.slice(:supplier, :uid)
    user_params.merge! auth.info.slice(:email, :first_name, :last_name)
    user_params[:facebook_picture_url] = auth.info.image
    user_params[:token] = auth.credentials.token
    user_params[:token_expiry] = Time.at(auth.credentials.expires_at)
    user_params = user_params.to_h

    user = User.find_by(supplier: auth.supplier, uid: auth.uid)
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

  def is_restaurant
    if !group.nil? and !supplier.nil?
      errors.add(:supplier, "has to be nil")
    end
  end

  def is_supplier
    if !supplier.nil? and !group.nil?
      errors.add(:restaurant, "has to be nil")
    end
  end

  def send_welcome_email
    UserMailer.welcome(self).deliver_now
  end
end
