require 'rails_helper'

RSpec.describe BookAssignments, type: :model do

  let (:books) {
    build_list(:book, 5).each_with_index do |book, i|
      book.title = "Book ##{i + 1}"
    end
    }

  let (:profiles) {
    build_list(:profile, 3)
  }

  let (:assignments) {
    book_counts_per_profile = [[0, 1, 2, 1, 2], [0, 0, 0, 1, 0], [0, 3, 1, 3, 1]]
    profiles.zip(book_counts_per_profile).map do |profile, book_counts|
      aset = AssignmentSet.new(profile: profile)
      books.zip(book_counts).each do |book, book_count|
        aset[book.key] = book_count if book_count > 0
      end
      aset
    end
  }

  let (:total_book_counts) {
    # derived from above
    [0, 4, 3, 5, 1]
  }

  let (:book_assignments) {
    BookAssignments.new(books, assignments)
  }

  it "contains all books" do
    expect(book_assignments.map(&:book)).to contain_exactly(*books)
  end


end
