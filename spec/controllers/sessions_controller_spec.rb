require 'rails_helper'
require 'record_extensions'
require 'fake_dataset_helper'

RSpec.describe SessionsController, type: :controller do

  Profile.extend RecordExtensions
  Profile.extend FakeDataset::WithFakeDataset

  let(:auth_environment) {
    {uid: "12345", image: "http://test.com/image12345"}
  }

  describe "POST #create" do
    
    context "with no matching profile" do
      before do
        Profile.delete_all
        @request.env["omniauth.auth"] = auth_environment
        @response = post :create
      end

      it "puts an AuthUser into session" do
        user = Marshal.load session[:user]
        expect(user.uid).to eq auth_environment[:uid]
        expect(user.image_url).to eq auth_environment[:image]
      end

      it "redirects to the creating a profile" do
        expect(response).to redirect_to(new_profile_url)
      end
    end
    
    context "with matching profile" do
      before do
        Profile.delete_all
        @request.env["omniauth.auth"] = auth_environment
        @profile = Profile.create! uid: auth_environment[:uid], name: "Test"
        @response = post :create
      end

      it "puts an AuthUser into session" do
        user = Marshal.load session[:user]
        expect(user.uid).to eq auth_environment[:uid]
      end

      it "adds the matching profile into session" do
        expect(session[:profile_id]).to eq @profile.id
      end

      it "redirects to the root url" do
        expect(response).to redirect_to(root_url)
      end
    end
  end

  describe "POST #destroy" do
    
    it "clears session[:user]" do 
      session[:user] = "Something"
      delete :destroy
      expect(session).to_not have_key(:user)
    end

    it "clears session[:profile_id]" do
      session[:profile_id] = "Something"
      delete :destroy
      expect(session).to_not have_key(:profile_id)
    end

    it "redirects to root" do
      delete :destroy
      expect(response).to redirect_to(root_url)
    end
  end

end
