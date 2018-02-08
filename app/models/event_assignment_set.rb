class EventAssignmentSet
  include Mongoid::Document
  field :event, type: Event
  field :year, type: Int
  field :books, type: List
end
