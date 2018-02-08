class EventAssignment
  include Mongoid::Document
  field :book, type: Book
  field :count, type: Int
  field :show, type: Mongoid::Boolean
end
