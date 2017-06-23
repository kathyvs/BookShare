require 'rails_helper'
#require 'record_extensions'
#require 'fake_dataset_helper'

RSpec.describe "Profile", type: :model do
  
  context "when initializing" do

    let(:valid_attributes) {
      {name: "Test", uid: "333"}
    }

    def replaced_attributes(attrs)
      valid_attributes.merge(attrs)
    end

    context "when validating" do

      it "default attributes are valid" do
        expect(Profile.new valid_attributes).to be_valid
      end

      it "name is required" do
        expect(Event.new replaced_attributes name: nil).to be_invalid
        expect(Event.new replaced_attributes name: "").to be_invalid
      end

      it "uuid is required"
      
    end

  end

  context "when authroization" do
    
    it "admin? requires the admin role"
      
  end

end
