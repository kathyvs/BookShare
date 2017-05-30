class AuthUser
  
  attr_accessor :uid, :image_url
  
  def initialize(uid, image_url)
    @uid = uid
    @image_url = image_url
  end
  
  def AuthUser.from_auth(dict)
    AuthUser.new(dict[:uid], dict[:image_url])
  end
end
