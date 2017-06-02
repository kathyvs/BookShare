require 'rails_helper'

RSpec.describe SessionsController, type: :controller do

  let(:auth_environment) {
    {uid: "12345", image_url: "http://test.com/image12345"}
  }

  let(:empty_session) { {} }
  
  describe "POST #create" do
    context "with no matching profile" do
      before {
        @request.env["omniauth.auth"] = auth_environment
        @response = post :create
      }

      it "puts an AuthUser into session" do
        user = session[:user]
        expect(user.uid).to eq auth_environment[:uid]
      end

      it "redirects to the creating a profile" do
        expect(response).to redirect_to(new_profile_url)
      end
    end
    
    context "with matching profile"

  end
end
