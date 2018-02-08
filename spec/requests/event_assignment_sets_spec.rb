require 'rails_helper'

RSpec.describe "EventAssignmentSets", type: :request do
  describe "GET /event_assignment_sets" do
    it "works! (now write some real specs)" do
      get event_assignment_sets_path
      expect(response).to have_http_status(200)
    end
  end
end
