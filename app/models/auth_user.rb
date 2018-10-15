#
# AuthUsers represent a person using the website, with their roles and authentication.
# This class is governed by Devise.
#
# This differs from a profile, which refers only to the owner of a collection of
# books being brought to an event.
#
class AuthUser

  include Mongoid::Document
  # Include default devise modules. Others available are:
  #:lockable, :timeoutable
  devise :database_authenticatable, :confirmable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
#         :omniauthable, :omniauth_providers => [:google]

  ## Database authenticatable
  field :email,              type: String, default: ""
  field :encrypted_password, type: String, default: ""

  ## Recoverable
  field :reset_password_token,   type: String
  field :reset_password_sent_at, type: Time

  ## Rememberable
  field :remember_created_at, type: Time

  ## Trackable
  field :sign_in_count,      type: Integer, default: 0
  field :current_sign_in_at, type: Time
  field :last_sign_in_at,    type: Time
  field :current_sign_in_ip, type: String
  field :last_sign_in_ip,    type: String

  # Confirmable
   field :confirmation_token,   type: String
   field :confirmed_at,         type: Time
   field :confirmation_sent_at, type: Time
   field :unconfirmed_email,    type: String # Only if using reconfirmable

  #Roles
  field :roles, type: Array, default: []

  attr_writer :current_profile

  field :image_url, type: String
  field :default_profile_index, type: Integer

  has_many :profiles, autosave: true

  accepts_nested_attributes_for :profiles

  def AuthUser.from_hash(dict)
    AuthUser.new(email: dict["email"], image_url: dict["image_url"])
  end

  def AuthUser.from_auth(dict)
    AuthUser.new(email: dict[:email], image_url: dict[:image])
  end

  # Returns the current profile for this request. This can either be a
  # direct selection, the default profile, or jsut the first profile.
  # In the majority of cases, there is only one profile for a user.
  def current_profile
    return @current_profile || default_profile || profiles[0]
  end

  def default_profile=(profile)
    found_index = profiles.index(profile)
    if (!found_index)
      found_index = profiles.size
      profiles << profile
    end
    self.default_profile_index = found_index
  end

  def default_profile
    default_profile_index && profiles[default_profile_index]
  end

  def find_profile(profile_id)
    profiles.first {|profile| profile.id === profile_id}
  end

  def admin?
    roles.include? :admin
  end
end
