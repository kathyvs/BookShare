#
# An assignment set is a list of books being brought by one profile for one event and one year.
#
class AssignmentSet
  include Mongoid::Document
  include GetOrUse

  field :arriving, type: Date
  field :leaving, type: Date
  field :year, type: Integer
  field :books, type: Hash, default: -> { Hash.new(0) }
  belongs_to :event
  belongs_to :profile

  def [](book_or_key)
    return books[get_or_use(book_or_key, :key)]
  end

  def []=(book_or_key, value)
    books[get_or_use(book_or_key, :key)] = value
  end
end
