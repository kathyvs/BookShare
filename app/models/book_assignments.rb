#
# BookAssignments converts a collection of assignment sets and books into
# a collection of BookAssignment objects, orgianized by books rather than
# by profile.  It is typically used in the context of a single event and year,
# but this is not enforced.
#
class BookAssignments

  include Enumerable
  include GetOrUse
  def initialize(books, assignments = [], book_counts = [])
    @book_assignments = {}
    books.each {|book| add_book(book)}
    assignments.each {|assignment_set| add_assignment_set(assignment_set)}
    book_counts.each {|book_count| add_book_count(book_count)}
  end

  def each(&block)
    book_assignments.each_value.sort_by do |book_assignment|
      book_assignment.book
    end.each(&block)
  end

  def [](book_or_key)
    return book_assignments[get_or_use(book_or_key, :key)]
  end

  def length
    book_assignments.length
  end

  def add_assignment_set(assignment_set)
    assignment_set.books.each_key do |book_key|
      book_assignments[book_key] << assignment_set if book_assignments.has_key? book_key
    end
  end

  def add_book_count(book_count)
    book_assignments[book_count.book.key].total_need = book_count.count
  end

  private

    attr_reader :book_assignments

    def add_book(book)
      @book_assignments[book.key] = BookAssignment.new(book)
    end

end
