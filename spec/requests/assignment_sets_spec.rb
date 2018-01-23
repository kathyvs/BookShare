require 'rails_helper'

RSpec.describe "AssignmentSets", type: :request do

  describe "GET /" do

    context "No one logged in" do

      it "redirects to current event and no profile" do
        get root_path
        expect(response).to be_redirect("aaa")
      end
    end
  end
  describe "GET /assignment_sets" do
    it "works! (now write some real specs)" do
      get assignment_sets_path
      expect(response).to have_http_status(200)
    end
  end
end
