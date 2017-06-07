require 'rails_helper'
require 'record_extensions'
require 'fake_dataset_helper'

RSpec.describe "Events", type: :request do

  Event.extend RecordExtensions
  Event.extend FakeDataset::WithFakeDataset

  let(:valid_attributes) {
    {name: "Test", month: Date.new(2017,06,03)}
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
      print "Event created count = #{@events.size}\n"
      get events_path
      print "Event saved count = #{Event.all.size}"
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
end
