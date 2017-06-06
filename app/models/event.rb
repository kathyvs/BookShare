class Event < ApplicationRecord

  attr_accessor :name, :month
  
  def Event.all 
    return ApplicationRecord.all("Event")
  end

  protected
    def add_entity_data(entity)
      entity["name"] = name
      entity["month"] = month.mon
    end
  
 end
