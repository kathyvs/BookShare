require 'rails_helper'

RSpec.describe Book, type: :model do
  
  context "persistence" do
    it "is persisted by Mongoid" do
      expect(Book).to be_mongoid_document
    end
  end
  
  context "validation" do
    pending "add validation"
  end
end
