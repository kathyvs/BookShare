class EventAssignment
  include Mongoid::Document

  # The book that is being assigned
  belongs_to :book
  embedded_in :event_assignment_set
  field :count, type: Integer
  field :show, type: Mongoid::Boolean
end
