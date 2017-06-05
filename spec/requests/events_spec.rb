require 'rails_helper'

RSpec.describe "Events", type: :request do
  describe "GET /events" do
    it "succeeds (even without authentication)" do
      pending "A valid all method"
       
      get events_path
      expect(response).to have_http_status(200)
    end

    it "display all events"

    it "marks the next event"

  end
end
