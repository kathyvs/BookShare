
class Profile

  include Mongoid::Document

  field :name, type: String
  belongs_to :user, class_name: "AuthUser"
  has_many :assignment_sets;

  validates_presence_of :name
  validates_presence_of :user

  def self.find_for_user(user)
    result = query.where(:uid, "=", user.uid).run
    result.first if result.size > 0
  end

  def id
   self._id.to_s
  end
end
