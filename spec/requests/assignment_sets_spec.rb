require 'rails_helper'

RSpec.describe "AssignmentSets", type: :request do
  describe "GET /assignment_sets" do
    it "works! (now write some real specs)" do
      get assignment_sets_path
      expect(response).to have_http_status(200)
    end
  end
end
