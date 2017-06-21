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
end
