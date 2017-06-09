class Event < ApplicationRecord

  attr_accessor :name, :month
  
  def month=(month)
    month = month.mon if month.respond_to? :mon
    print "Setting month to #{month}"
    @month = month
  end

  def month_name
    Date::MONTHNAMES[month]
  end

  protected
    def add_entity_data(entity)
      entity["name"] = name
      entity["month"] = month
    end
  
    def self.from_entity(entity)
      Event.new id: entity.key.id, name: entity['name'], month: entity['month']
    end
 end
