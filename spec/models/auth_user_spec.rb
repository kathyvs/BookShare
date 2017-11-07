require 'rails_helper'
#require 'record_extensions'
#require 'fake_dataset_helper'

RSpec.describe "AuthUser", type: :model do
  
  context "persistence" do
    
    it "is persisted by Mongoid" do
      expect(AuthUser).to be_mongoid_document
    end
  end
  
  context "when pulling from auth info" do

    let(:authinfo) {
      {uid: "12345", image: "https://test.com"}
    }

    it "copies uid" do
      user = AuthUser.from_auth authinfo
      expect(user.uid).to eq authinfo[:uid]
    end

    it "copies image_url from image" do
      user = AuthUser.from_auth authinfo
      expect(user.image_url).to eq authinfo[:image]
    end
    
  end 
  
  context "current profile" do
    before do
      @user = AuthUser.new(uid: "1234", image_url: "test.com")
    end
    
    it "is null when no profiles" do
      expect(@user.current_profile).to be_nil
    end
  end
  
  context "checking admin" do
    before do
      @user = AuthUser.new(uid: "1234", image_url: "test.com")
    end
    
    it "is false when no profile" do
      expect(@user).to_not be_admin
    end
    
    it "is false when current profile is not admin" do
      profile = Profile.new(name: "Test")
      @user.current_profile = profile
      expect(@user).to_not be_admin
    end
    
    it "is true when profile is admin" do
      profile = Profile.new name: "Admin"
      profile.roles = [:admin]
      @user.current_profile = profile
      expect(@user).to be_admin
    end
  end    
end
