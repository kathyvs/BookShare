class BookCount
  include Mongoid::Document

  # The book that is being assigned
  belongs_to :book
  embedded_in :event
  field :count, type: Integer
  field :show, type: Mongoid::Boolean
end
