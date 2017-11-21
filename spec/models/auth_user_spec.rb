require 'rails_helper'

RSpec.describe "AuthUser", type: :model do
  
  context "persistence" do
    
    it "is persisted by Mongoid" do
      expect(AuthUser).to be_mongoid_document
    end
  end
  
  context "when pulling from auth info" do

    let(:authinfo) {
      {uid: "12345", email: "test@test.com", image: "https://test.com"}
    }

    it "copies email" do
      user = AuthUser.from_auth authinfo
      expect(user.email).to eq(authinfo[:email])
    end

    it "copies image_url from image if exists" do
      user = AuthUser.from_auth authinfo
      expect(user.image_url).to eq(authinfo[:image])
    end

    it "sets image_url to nil if it does not exist" do
      authinfo.delete :image
      user = AuthUser.from_auth authinfo
      expect(user.image_url).to be_nil
    end
  end
      
  context "current profile" do
    before do
      @user = build(:user)
    end
    
    context "when current profile set" do
      
      before do
        @profile = Profile.new(name: "Current")
        @profile.user = @user
        @user.current_profile = @profile
      end

      it "uses the set current profile" do
        expect(@user.current_profile).to eq(@profile)
      end
      
    end
    
    context "when no current profile set" do
      context "when no profiles" do
        before do 
          @user.profiles.clear
        end
        it "is null" do
          expect(@user.current_profile).to be_nil
        end
      end
    
      context "when profiles" do
        
        before do
          @first_profile = Profile.new(name: "First")
          @default_profile = Profile.new(name: "Default")
          @profiles = [@first_profile, Profile.new(name: "Bad"), @default_profile]
            @user.profiles = @profiles 
        end
        
        context "when no default profile" do
          it "is the first profile in profiles" do
            expect(@user.current_profile).to eq(@first_profile)
          end
        end

        context "when default profile is set" do
          before do 
            @user.default_profile = @default_profile
          end

          it "is the default profile" do
            expect(@user.current_profile).to eq(@default_profile) 
          end
        end

      end
    end
  end
  
  context "checking admin" do
    before do
      @user = build(:user)
      @user.profiles.clear
    end
    
    it "is false when no profile" do
      expect(@user).to_not be_admin
    end
    
    it "is false when current profile is not admin" do
      @user.current_profile = build(:profile)
      expect(@user).to_not be_admin
    end
    
    it "is true when profile is admin" do
      @user.current_profile = build(:admin)
      expect(@user).to be_admin
    end
  end    
end
