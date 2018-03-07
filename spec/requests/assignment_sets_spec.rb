require 'rails_helper'
require 'support/factory_bot'
require 'support/database_cleaner'

RSpec.describe "AssignmentSets", type: :request do

  describe "GET /events/3/2018/assignments" do
    it "works! (now write some real specs)" do
      e = create(:march_event)
      get event_assignments_path(e.id, 2018)
      expect(response).to have_http_status(200)
    end
  end
end
