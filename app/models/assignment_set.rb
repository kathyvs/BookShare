class AssignmentSet
  include Mongoid::Document
  field :arriving, type: Date
  field :leaving, type: Date
  field :year, type: Integer
  
  belongs_to :event
  belongs_to :profile
end
