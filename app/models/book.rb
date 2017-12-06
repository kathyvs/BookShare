class Book
  include Mongoid::Document
  
  field :title, type: String
  field :author, type: String
  field :type, type: Symbol
  field :short_name, type: String
  field :volume, type: Integer
  
  has_many :assignments
  
  validates_presence_of :title
  validates_presence_of :type
  
  def has_author?
    has_attribute? :author
  end
  
  def has_short_name?
    has_attribute? :short_name
  end
end
