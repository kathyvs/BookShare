
class Profile
  
  include Mongoid::Document

  field :name, type: String
  embedded_in :user, class_name: "AuthUser"
  has_many :assignment_sets;
  has_many :assignments;
  
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
