require 'rails_helper'
#require 'record_extensions'
#require 'fake_dataset_helper'

RSpec.describe "Profile", type: :model do

  context "persistence" do
    
    it "is persisted by Mongoid" do
      expect(Profile).to be_mongoid_document
    end
  end
   
  context "when initializing" do

    let(:valid_attributes) {
      {name: "Test", uid: "3333"}
    }

    def replaced_attributes(attrs)
      valid_attributes.merge(attrs)
    end

    context "when validating" do

      it "default attributes are valid" do
        expect(Profile.new valid_attributes).to be_valid
      end

      it "name is required" do
        expect(Profile.new replaced_attributes name: nil).to be_invalid
        expect(Profile.new replaced_attributes name: "").to be_invalid
      end

      it "uid is required"
      
    end

  end

  context "when authorization" do
    
    it "admin? requires the admin role" do
      profile = Profile.new name: "Test", uid: "3333"
      expect(profile).to_not be_admin
      profile.roles = [:admin]
      expect(profile).to be_admin
    end
  end

end
