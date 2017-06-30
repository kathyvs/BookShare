class AuthUser
  
  attr_reader :uid, :image_url
  attr_accessor :profile
  
  def initialize(uid, image_url)
    @uid = uid
    @image_url = image_url
  end
  
  def AuthUser.from_hash(dict)
    AuthUser.new(dict["uid"], dict["image_url"])
  end

  def AuthUser.from_auth(dict)
    AuthUser.new(dict[:uid], dict[:image])
  end
  
  def admin?
    profile && profile.admin?
  end
end
