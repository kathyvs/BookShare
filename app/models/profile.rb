
class Profile
  
  include Mongoid::Document

  field :name, type: String
  field :roles, type: Array, default: []
  embedded_in :user, class_name: "AuthUser"
  
  validates_presence_of :name
  validates_presence_of :user
  
  def self.find_for_user(user)
    result = query.where(:uid, "=", user.uid).run
    result.first if result.size > 0
  end

  def admin?
    roles.include? :admin
  end

end
