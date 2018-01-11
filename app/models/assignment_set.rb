#
# An assignment set is a list of books being brought by one profile for one event and one year.
#
class AssignmentSet
  include Mongoid::Document
  field :arriving, type: Date
  field :leaving, type: Date
  field :year, type: Integer
  field :books, type: Hash, default: -> { Hash.new(0) }
  belongs_to :event
  belongs_to :profile

  def count_for(book_or_key)
    key = book_or_key.respond_to?(:key) ? book_or_key.key : book_or_key
    return books[key]
  end
end
