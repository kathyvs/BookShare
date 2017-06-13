class Event < ApplicationRecord

  attr_accessor :name, :month
  
  MIN_MONTH = 1
  MAX_MONTH = 12

  validates_presence_of :name, :month
  validates_numericality_of :month, only_integer: true, 
      less_than_or_equal_to: MAX_MONTH, 
      greater_than_or_equal_to: MIN_MONTH

  def self.all_months
    return (MIN_MONTH .. MAX_MONTH)
  end
  def month=(month)
    month = month.mon if month.respond_to? :mon
    @month = month
  end

  def month_name
    Date::MONTHNAMES[month.to_i]
  end

  protected
    def add_entity_data(entity)
      entity["name"] = name
      entity["month"] = month
    end
  
    def copy_from_entity(entity)
      self.name = entity['name']
      self.month = entity['month']
    end
 end
