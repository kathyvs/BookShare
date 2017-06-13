require 'rails_helper'
require 'record_extensions'
require 'fake_dataset_helper'

RSpec.describe "Events", type: :request do

  Event.extend RecordExtensions
  Event.extend FakeDataset::WithFakeDataset

  let(:valid_attributes) {
    {name: "Test", month: 06}
  }

  let(:invalid_attributes) {
    {name: "Bad", month: -100}
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
      get events_url(id: @event.id)
    end

    it "returns a success response (even without authentication)" do
      expect(response).to be_success
    end

    it "adds data from the event into the response" do
      expect(response.body).to include(@event.name)
    end
  end

  describe "GET /events/new" do
    
    context "when authorized" do

      it "returns a success response" do
        get new_event_path
        expect(response).to be_success
      end

      it "renders a form" do
        get new_event_path
        expect(response.body).to include(events_path)
        expect(response.body).to include("January")
      end
    end

    context "when unauthorized" do

      it "returns a permissions error"
    end
  end

  describe "GET #edit" do
    
    context "when authorized" do

      before do 
        @event = Event.create! valid_attributes
        get edit_event_url id: event.to_param
      end

      it "returns a success response" do
        expect(response).to be_success
      end

      it "renders a form" do
        expect(response.body).to include(events_path)
        expect(response.body).to include("input")
      end
    
    end

    context "when unauthorized" do

      it "returns a permissions error"
    end
  end

  describe "POST #create" do

    context "when authorized" do
      context "with valid params" do
        it "creates a new Event" do
          expect {
            post events_path params: {event: valid_attributes}
          }.to change(Event, :count).by(1)
        end

        it "redirects to the created event" do
           post events_path, params: {event: valid_attributes}
          expect(response).to redirect_to(Event.all.last)
        end
      end

      context "with invalid params" do
        it "returns a success response (i.e. to display the 'new' template)" do
          pending "A valid save method"
          post events_path, params: {event: valid_attributes}
          expect(response).to be_success
        end
      end
    end

    context "when unauthorized" do

      it "returns a permissions error"
    end
  end

  describe "PUT #update" do
    context "when authorized" do
      context "with valid params" do
        let(:new_attributes) {
          {name: "New Name", month: 8}
        }

        before do 
          @event = Event.create! valid_attributes
        end
  
        it "updates the requested event" do
          put event_path(@event.id), params: {id: @event.to_param, event: new_attributes}
          @event.reload
          expect(@event.name).to eq(new_attributes[:name])
        end
  
        it "redirects to the event" do
          put event_path(event.id), params: {id: event.to_param, event: new_attributes}
          expect(response).to redirect_to(@event)
        end
      end
  
      context "with invalid params" do
        it "returns a success response (i.e. to display the 'edit' template)" do
          event = Event.create! valid_attributes
          put event_path(event.id), params: {id: event.to_param, event: invalid_attributes}
          expect(response).to be_success
        end
      end
    end
    
    context "when unauthorized" do

      it "returns a permissions error"
    end
  end
end
