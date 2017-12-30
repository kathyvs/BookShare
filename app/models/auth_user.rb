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
 
  attr_accessor :current_profile
  
  field :image_url, type: String
  field :default_profile_index, type: Integer
  
  embeds_many :profiles
  
  #accepts_nested_attributes_for :default_profile
  accepts_nested_attributes_for :profiles
  
  def AuthUser.from_hash(dict)
    AuthUser.new(email: dict["email"], image_url: dict["image_url"])
  end

  def AuthUser.from_auth(dict)
    AuthUser.new(email: dict[:email], image_url: dict[:image])
  end
  
  def current_profile
    return @current_profile || default_profile || profiles[0]
  end
  
  def default_profile=(profile)
    found_index = nil
    profiles.each_with_index do |p, i|
      found_index = i if p == profile
    end
    if (!found_index)
      found_index = profiles.size
      profiles << profile
    end
    self.default_profile_index = found_index
  end

  def default_profile
    default_profile_index && profiles[default_profile_index]
  end  
  
  def admin?
    current_profile && current_profile.admin?
  end
end
