require 'rails_helper'
#require 'record_extensions'
#require 'fake_dataset_helper'

RSpec.describe "AuthUser", type: :model do
  
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
  
  context "checking admin" do
    before do
      @user = AuthUser.new "1234", "test.com"
    end
    
    it "is false when no profile" do
      expect(@user).to_not be_admin
    end
    
    it "is false when profile is not admin" do
      @user.profile = Profile.new name: "Test"
      expect(@user).to_not be_admin
    end
    
    it "is true when profile is admin" do
      @user.profile = Profile.new name: "Admin"
      @user.profile.roles = [:admin]
      expect(@user).to be_admin
    end
  end    
end
