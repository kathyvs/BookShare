
class Profile < ApplicationRecord

  attr_accessor :uid, :name
  
  def self.find_for_user(user)
    result = query.where(:uid, "=", user.uid).run
    result.first if result.size > 0
  end

  # For record use only
  def add_entity_data(entity)
    entity[:uid] = uid
    entity[:name] = name
  end

  def copy_from_entity(entity)
    self.uid = entity[:uid]
    self.name = entity[:name]
  end
end
