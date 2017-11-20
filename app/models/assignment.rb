class Assignment
  include Mongoid::Document
  
  field :year, type: Integer
  field :count, type: Integer
  
  belongs_to (:book)
  belongs_to (:event)
  belongs_to (:profile)
end
