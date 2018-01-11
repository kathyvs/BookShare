require 'rails_helper'

RSpec.describe BookAssignment, type: :model do

  let(:book) {
    Book.new(title: "Test Book", author: "William of SCA")
  }

  let(:profiles) {
    build_list(:profile, 4)
  }

  let(:counts) {
    [1, 0, 2, 1]
  }

  let(:assignment_sets) {
    set_by_profile = {}
    counts.each_with_index do |count, profile_index|
      set_by_profile[profile_index] ||= AssignmentSet.new(profile: profiles[profile_index])
      set_by_profile[profile_index].books[book.key] = count
    end
    return set_by_profile.values
  }

  let(:book_assignment) {
    book_assignment = BookAssignment.new(book)
    assignment_sets.each do |aset|
      book_assignment << aset
    end
    book_assignment
  }

  it "contains a total count its book" do
    expect(book_assignment.total_count).to eq(counts.sum)
  end
end
