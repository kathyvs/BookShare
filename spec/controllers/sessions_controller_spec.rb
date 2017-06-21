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
        @request.env["omniauth.auth"] = auth_environment
        @profile = Profile.create! uid: auth_environment[:uid], name: "Test"
        print "Created profile: #{@profile} with id #{@profile.id}\n"
        @response = post :create
      end

      it "puts an AuthUser into session" do
        user = Marshal.load session[:user]
        expect(user.uid).to eq auth_environment[:uid]
      end

      it "adds the matching profile into session" do
        expect(session[:profile_id]).to eq @profile.id
      end

      it "redirects to the original url"
    end
  end
end
