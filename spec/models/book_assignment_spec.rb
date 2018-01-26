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
      set_by_profile[profile_index][book.key] = count
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

  it "contains a list of pairs of profiles and counts" do
    expect(book_assignment.profile_assignments).to include(
      [profiles[0], counts[0]], [profiles[2], counts[2]], [profiles[3], counts[3]])
  end

  it "sorts the profiles by name" do
    names = ["B", "X", "A", "C"]
    profiles.zip(names).each do |profile, name|
      profile.name = name
    end
    expect(book_assignment.profile_assignments.map{ |p, c| p.name }).to eq(names.sort.slice(0, 3))
  end

  it "skips profiles with a count of 0" do
    expect(book_assignment.profile_assignments).to_not include([profiles[1], counts[1]])
  end

  context "as JSON" do

    it "saves the book" do
      expect(book_assignment.as_json['book']).to eq(book.as_json)
    end

    it "saves the mapping as association list" do
      included_indexes = [0, 2, 3]
      included_indexes.each do |index|
        expect(book_assignment.as_json['profile_assignments']).to include({
          'profile' => profiles[index].as_json,
          'count' => counts[index]
          })
      end
    end

  end
end
