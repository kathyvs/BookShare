
class Profile < ApplicationRecord

  attr_accessor :uid, :name
  
  def add_entity_data(entity)
    entity[:uid] = uid
    entity[:name] = name
  end
end
