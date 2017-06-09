require 'rails_helper'
require 'record_extensions'
require 'fake_dataset_helper'

RSpec.describe "Events", type: :request do

  Event.extend RecordExtensions
  Event.extend FakeDataset::WithFakeDataset

  let(:valid_attributes) {
    {name: "Test", month: 06}
  }

  describe "GET /events" do

    attr_reader :events
    before do 
      names = ["First", "Second", "Third"]
      @events = []
      names.each do |n|
        attrs = valid_attributes.clone
        attrs[:name] = n
        @events << Event.create!(attrs)
      end
      get events_path
    end

    it "succeeds (even without authentication)" do
      expect(response).to have_http_status(200)
    end

    it "displays all events" do
      @events.each do |e|
        expect(response.body).to include(e.name)
      end
    end

    it "marks the next event"

  end

  describe "GET /events/:id" do
    before do 
      @event = Event.create! valid_attributes
      get "/events/#{@event.to_param}"
    end

    it "returns a success response (even without authentication)" do
      expect(response).to be_success
    end
  end

end
