class EventAssignmentSet
  include Mongoid::Document

  belongs_to :event
  embeds_many :books, class_name: EventAssignment
end
