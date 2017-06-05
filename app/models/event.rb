require 'google/cloud/datastore'

class Event < ApplicationRecord

  attr_accessor :id, :name, :month
  
  def Event.all 
    return []
  end
  
  #
  # Used to save to datastore
  def to_entity
    entity = Google::Cloud::Datastore::Entity.new
    entity.key = Google::Cloud::Datastore::Key.new entity_name, id
    entity["name"] = name
    entity["month"] = month.mon
    entity
  end
  
end
