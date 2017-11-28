require 'rails_helper'
require 'support/database_cleaner'

RSpec.describe Assignment, type: :model do
  context "persistence" do
    it "is persisted by Mongoid" do
      expect(Profile).to be_mongoid_document
    end
  end


end
