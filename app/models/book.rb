class Book
  include Mongoid::Document
  
  field :title, type: String
  field :author, type: String
  field :type, type: Symbol
  field :volume, type: Integer
  
  has_many :assignments
  
  validates_presence_of :title
  validates_presence_of :type
end
