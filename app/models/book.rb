class Book < ApplicationRecord
  
  attr_accessor :title, :author, :short_name
  
  def has_author?
    not author.blank?
  end
  
  def has_short_name?
    not short_name.blank?
  end
  
  def add_entity_data(entity)
    entity[:title] = title
    entity[:author] = author
    entity[:short_name] = short_name
  end
  
  def copy_from_entity(entity)
    self.title = entity['title']
    self.author = entity['author']
    self.short_name = entity['short_name']
  end
end