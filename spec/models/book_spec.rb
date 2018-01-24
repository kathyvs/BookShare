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
