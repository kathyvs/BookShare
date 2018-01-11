class BookAssignments

  include Enumerable

  def initialize(books, assignments = [])
    @book_assignments = {}
    books.each {|book| add_book(book)}
  end

  def each(&block)
    book_assignments.each_value(&block)
  end

  private

    attr_reader :book_assignments

    def add_book(book)
      @book_assignments[book.key] = BookAssignment.new(book)
    end

end
