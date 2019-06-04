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

  let (:book_counts) do
    need = [-1, 6, 4, 1, 2]
    books.zip(need).map do |book, need|
      BookCount.new(book: book, count: need)
    end
  end

  let (:total_book_counts) {
    # derived from above
    [0, 4, 3, 5, 3]
  }

  let (:still_needed) {
    # derived from above
    [-1, 2, 1, -4, -1]
  }

  let (:book_assignments) {
    BookAssignments.new(books, assignments, book_counts)
  }

  it "contains all books in order" do
    expect(book_assignments.map(&:book)).to eq(books.sort)
  end

  it "contains all assignments" do
    expect(assignments.count).to be > 0
    assignments.each do |assignment_set|
      expect(assignment_set.books.count).to be > 0
      assignment_set.books.each do |book_key, count|
        book_assignment = book_assignments[book_key]
        expect(book_assignment[assignment_set.profile_id]).to be >= count
      end
    end
  end

  it "contains the number of books still needed" do
    expect(still_needed.count).to be > 0
    books.zip(still_needed).each do |book, need|
      book_assignment = book_assignments[book]
      expect(book_assignment.need).to eq(need)
    end
  end
end
