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
end
