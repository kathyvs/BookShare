require 'rails_helper'
#require 'record_extensions'
#require 'fake_dataset_helper'

RSpec.describe "Event", type: :model do

  def book_counts(book_sym, count)
    BookCount.new({book: books[book_sym], count: count})
  end

  context "persistence" do

    it "is persisted by Mongoid" do
      expect(Event).to be_mongoid_document
    end

  end

  context "when initializing" do

    let(:valid_attributes) {
      {name: "Test", month: 8}
    }

    let(:books) {
      [:parker, :bahlow].map { |k| [k, create(k)] }.to_h
    }

    def replaced_attributes(attrs)
      valid_attributes.merge(attrs)
    end

    it "converts dates to month" do
      month = 5
      event = Event.new(replaced_attributes month: Date.new(2017, month))
      expect(event.month).to eq(month)
    end

    it "converts counts to books" do
      book_countlist = [book_counts(:parker, 3), book_counts(:bahlow, 1)]
      count_map = book_countlist.map {|bc| [bc.book_id.to_s, bc.count.to_s]}.to_h
      event = Event.new(replaced_attributes counts: count_map)
      expect(event.books.map {|bc| [bc.book_id, bc.count]}).to eq(
        book_countlist.map {|bc| [bc.book_id, bc.count]})
    end

    context "when validating" do

      it "default attributes are valid" do
        expect(Event.new valid_attributes).to be_valid
      end

      it "name is required" do
        expect(Event.new replaced_attributes name: nil).to be_invalid
        expect(Event.new replaced_attributes name: "").to be_invalid
      end

      it "month is required" do
        expect(Event.new replaced_attributes month: nil).to be_invalid
      end

      it "month must be an integer" do
        expect(Event.new replaced_attributes month: "X").to be_invalid
        expect(Event.new replaced_attributes month: 3.5).to be_invalid
      end

      it "month must no greater than 12" do
        expect(Event.new replaced_attributes month: 13).to be_invalid
        expect(Event.new replaced_attributes month: 500).to be_invalid
      end

      it "month must be no less than 1" do
        expect(Event.new replaced_attributes month: 0).to be_invalid
        expect(Event.new replaced_attributes month: -35).to be_invalid
      end

      it "book counts can be negative" do
        expect(Event.new replaced_attributes books: [book_counts(:parker, -3)]).to be_valid
      end
    end

  end

  context "when updating" do

    let(:books) {
      [:parker, :bahlow].map { |k| [k, create(k)] }.to_h
    }

    let(:event) {
      Event.new(name: "Update Test", month: 3,
        counts: {books[:parker].id => 1})
    }

    it "converts dates to month" do
      month = 4
      event.update(month: Date.new(2018, month))
      expect(event.month).to eq(month)
    end

    it "converts counts to books" do
      book_countlist = [book_counts(:parker, 2), book_counts(:bahlow, -1)]
      count_map = book_countlist.map {|bc| [bc.book_id.to_s, bc.count.to_s]}.to_h
      event.update(counts: count_map)
      expect(event.books.map {|bc| [bc.book_id, bc.count]}).to eq(
        book_countlist.map {|bc| [bc.book_id, bc.count]})
    end

  end
  context "current event" do

    let (:events) {
      [:january, :march, :may, :june].map { |k| [k, create("#{k}_event".to_sym)] }.to_h
    }

    it "finds by event id if given id" do
      event = events[:march]
      expect(Event.current(event.id)).to eq(event)
    end

    it "uses the first event in current month if exists"

    it "uses the first event in the last month if none in current month"

    it "uses the event in the nearest following month otherwise"
  end


  context "counts_for" do

    let (:books) {
      (1..7).map do |index|
        Book.new(title: "Book ##{index}", type: :test)
      end
    }

    let (:event) {
      Event.new(name: "Test Event", month: 8)
    }

    def count_hash(count_assoc)
      count_assoc.map do |index, count|
        book = books[index]
        [book.id, count]
      end.to_h
    end

    def add_counts(*count_assoc)
      count_assoc.map do |index, count|
        event.books << BookCount.new(book: books[index], count: count)
      end
    end

    it "returns an entry for every book in the arguments " do
      included_books = books[0..4]
      counts = event.counts_for(included_books)
      book_list = counts.map(&:first)
      expect(book_list).to eq(included_books)
    end

    it "returns the book count if it is in the event" do
      count_assoc = [[1, 2], [2,  3], [4, -1], [6, 0]]
      add_counts(*count_assoc)
      count_hash = count_hash(count_assoc)

      counts = event.counts_for(books)
      counts.each do |book, count|
        if count_hash.has_key? book.id
          expect(count).to eq(count_hash[book.id])
        end
      end
    end

    it "returns 0 if the corresponding book count is missing" do
      set_book = books[4]
      event.books << BookCount.new(book: set_book, count: 3)
      event.counts_for(books).each do |book, count|
        unless book == set_book
          expect(count).to eq(0)
        end
      end
    end
  end

end
