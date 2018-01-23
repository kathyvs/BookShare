class BookAssignments

  include Enumerable
  include GetOrUse
  def initialize(books, assignments = [])
    @book_assignments = {}
    books.each {|book| add_book(book)}
    assignments.each {|assignment_set| add_assignment_set(assignment_set)}
  end

  def each(&block)
    book_assignments.each_value(&block)
  end

  def [](book_or_key)
    return book_assignments[get_or_use(book_or_key, :key)]
  end

  def add_assignment_set(assignment_set)
    assignment_set.books.each_key do |book_key|
      book_assignments[book_key] << assignment_set if book_assignments.has_key? book_key
    end
  end
  private

    attr_reader :book_assignments

    def add_book(book)
      @book_assignments[book.key] = BookAssignment.new(book)
    end

end
