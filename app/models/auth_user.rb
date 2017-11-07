class AuthUser
  
  include Mongoid::Document
  
  attr_accessor :current_profile
  
  field :uid, type: String
  field :image_url, type: String
  embeds_many :profiles
  
  def AuthUser.from_hash(dict)
    AuthUser.new(uid: dict["uid"], image_url: dict["image_url"])
  end

  def AuthUser.from_auth(dict)
    AuthUser.new(uid: dict[:uid], image_url: dict[:image])
  end
  
  def admin?
    current_profile && current_profile.admin?
  end
end
