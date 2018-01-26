require 'rails_helper'
require 'support/validation'

RSpec.describe Book, type: :model do

  context "persistence" do
    it "is persisted by Mongoid" do
      expect(Book).to be_mongoid_document
    end
  end

  context "when validating" do

    include Validation

    let(:valid_attributes) {
      {title: "Good title",  type: :example}
    }

    it "default attributes are valid" do
       expect(Book.new(valid_attributes)).to be_valid
    end

    it "title is required" do
      expect(create_with_replaced(Book, title: nil)).to_not be_valid_at(:title)
      expect(create_with_replaced(Book, title: "")).to_not be_valid_at(:title)
    end

    it "type is required" do
      expect(create_with_replaced(Book, type: nil)).to_not be_valid_at(:type)
    end
  end

  context "when sorting" do

    def test_sort(books)
      shuffled_books = books.shuffle
      expect(shuffled_books.sort).to eq(books)
    end

    it "sorts first by author" do
      authors = ["A", "B", "C", "D"]
      titles = ["T1", "T3", "T1", "T2"]
      test_sort(authors.zip(titles).map {|a, t| Book.new(author: a, title: t) })
    end

    it "sorts by title when author is identical" do
      authors = ["A", "A", "A", "A", "C"]
      titles = ["D", "E", "F", "G", "D"]
      test_sort(authors.zip(titles).map {|a, t| Book.new(author: a, title: t) })
    end

    it "sorts by id last" do
      ids = [1, 2, 3, 4, 5]
      test_sort(ids.map {|id| Book.new(title: "T", id: id)})
    end
  end

  context "as json" do

    let(:book) {
      Book.new(title: "Test Title", author: "John Doe", type: "test")
    }

    it "does not include _id" do
      expect(book.as_json).to_not have_key("_id")
    end

    [:key, :title, :author].each do |attr|
      it "includes #{attr}" do
        expect(book.as_json[attr.to_s]).to eq(book.send(attr))
      end
    end

    it "round trips properly" do
      expect(Book.json_create(book.as_json)).to eq(book)
    end
  end
end
