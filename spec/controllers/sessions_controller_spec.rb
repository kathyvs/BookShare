require 'rails_helper'
require 'record_extensions'
require 'fake_dataset_helper'

RSpec.describe SessionsController, type: :controller do

  Profile.extend RecordExtensions
  Profile.extend FakeDataset::WithFakeDataset

  let(:auth_environment) {
    {uid: "12345", image_url: "http://test.com/image12345"}
  }

  describe "POST #create" do
    context "with no matching profile" do
      before do
        @request.env["omniauth.auth"] = auth_environment
        @response = post :create
      end

      it "puts an AuthUser into session" do
        user = session[:user]
        expect(user.uid).to eq auth_environment[:uid]
      end

      it "redirects to the creating a profile" do
        expect(response).to redirect_to(new_profile_url)
      end
    end
    
    context "with matching profile" do
      before do
        @request.env["omniauth.auth"] = auth_environment
        @profile = Profile.create! uid: auth_environment[:uid], name: "Test"
        @response = post :create
      end

      it "puts an AuthUser into session" do
        user = session[:user]
        expect(user.uid).to eq auth_environment[:uid]
      end

      it "adds the matching profile into session" do
        expect(session[:profile_id]).to eq @profile.id
      end

      it "redirects to the original url"
    end
  end
end
