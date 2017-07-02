
class Profile < ApplicationRecord

  attr_accessor :uid, :name, :roles
  
  validates_presence_of :name
  
  def initialize attrs
    super attrs
    self.roles ||= []
  end

  def self.find_for_user(user)
    result = query.where(:uid, "=", user.uid).run
    result.first if result.size > 0
  end

  def admin?
    roles.include? :admin
  end

  # For record use only
  def add_entity_data(entity)
    entity[:uid] = uid
    entity[:name] = name
    entity[:roles] = roles.map {|r| r.to_s}
  end

  def copy_from_entity(entity)
    self.uid = entity[:uid]
    self.name = entity[:name]
    self.roles = entity[:roles].map {|r| r.to_sym} if entity[:roles]
  end
end
