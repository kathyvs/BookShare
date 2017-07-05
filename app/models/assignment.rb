class Assignment < ApplicationRecord
  
  attr_accessor :event_id, :year, :profile_id, :bringing
  
  def self.all_for(event_id, year)
    Assignment.query.where(:event_id, "=", event_id).where(:year, "=", year).run
  end

  def add_entity_data entity
    entity[:event_id] = event_id
    entity[:year] = year
    entity[:profile_id] = profile_id
    entity[:bringing_books] = bringing.keys
    entity[:bringing_number] = bringing.values
  end
  
  def copy_from_entity entity
    self.event_id = entity[:event_id]
    self.year = entity[:year]
    self.profile_id = entity[:profile_id]
    self.bringing = entity[:bringing_books].zip(entity[:bringing_number]).to_h
  end
end