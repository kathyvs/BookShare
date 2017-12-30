require 'rails_helper'
require 'support/factory_bot'
require 'support/validation'

RSpec.describe "Profile", type: :model do

  context "persistence" do
    it "is persisted by Mongoid" do
      expect(Profile).to be_mongoid_document
    end
  end
   
  context "when initializing" do

    let(:user) {
      build(:user)
    }
    
    let(:valid_attributes) {
      {name: "Test", user: user}
    }

    context "when validating" do

      include Validation
      
      it "default attributes are valid" do
        expect(Profile.new(valid_attributes)).to be_valid
      end

      it "name is required" do
        expect(create_with_replaced(Profile, name: nil)).to_not be_valid_at(:name)
        expect(create_with_replaced(Profile, name: "")).to_not be_valid_at(:name)
      end

      it "user is required" do
        expect(create_with_replaced(Profile, user: nil)).to be_invalid
      end
      
    end

  end

end
