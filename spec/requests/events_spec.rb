require 'rails_helper'
require 'support/database_cleaner'

RSpec.describe "Events", type: :request do

  let(:valid_attributes) {
    {name: "Test", month: 06}
  }

  let(:invalid_attributes) {
    {name: "Bad", month: -100}
  }

  describe "GET /events" do

    attr_reader :events
    before do
      Event.delete_all
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

      before do
        sign_in :admin
        create(:parker)
        create(:ssno)
        create(:ncmj)
      end

      it "returns a success response" do
        get new_event_path
        expect(response).to be_success
      end

      it "renders a form" do
        get new_event_path
        expect(response.body).to include(events_path)
        expect(response.body).to include("January")
      end

      it "renders a table containing all books" do
        get new_event_path
        expect(Book.all.size).to be > 0
        Book.all.each do |book|
          expect(response.body).to include(book.title)
        end
      end

      after do
        sign_out
      end

    end

    context "when unauthorized" do

      it "returns a unauthenticated error for no users" do
        get new_event_path
        expect(response).to have_http_status(:unauthorized)
      end

      it "returns a permissions error for normal users" do
        sign_in :normal
        get new_event_path
        expect(response).to have_http_status(:forbidden)
      end

      after do
        sign_out
      end
    end
  end

  describe "GET #edit" do

    before do
      @event = Event.create! valid_attributes
    end

    context "when authorized" do

      before do
        sign_in :admin
        get edit_event_url id: @event.to_param
      end

      it "returns a success response" do
        expect(response).to be_success
      end

      it "renders a form" do
        expect(response.body).to include(events_path)
        expect(response.body).to include("input")
      end

      after do
        sign_out
      end

    end

    context "when unauthorized" do

     it "returns a unauthenticated error for no users" do
        get edit_event_url id: @event.to_param
        expect(response).to have_http_status(:unauthorized)
      end

      it "returns a permissions error for normal users" do
        sign_in :normal
        get edit_event_url id: @event.to_param
        expect(response).to have_http_status(:forbidden)
      end

      after do
        sign_out
      end
    end

    context "when missing" do

      it "returns a missing error" do
        get edit_event_url id: -1
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe "POST #create" do

    context "when authorized" do

      before do
        sign_in :admin
      end

      context "with valid params" do
        it "creates a new Event" do
          expect {
            post events_path params: {event: valid_attributes}
          }.to change(Event, :count).by(1)
        end

        it "redirects to the show event page" do
          post events_path, params: {event: valid_attributes}
          new_event = Event.where(name: valid_attributes[:name]).last
          expect(response).to redirect_to(new_event)
        end
      end

      context "with invalid params" do
        it "returns a success response (i.e. to display the 'new' template)" do
          post events_path, params: {event: invalid_attributes}
          expect(response).to be_success
        end
      end

      after do
        sign_out
      end

    end

    context "when unauthorized" do

      it "returns a unauthenticated error for no users" do
        post events_path, params: {event: valid_attributes}
        expect(response).to have_http_status(:unauthorized)
      end

      it "returns a permissions error for normal users" do
        sign_in :normal
        post events_path, params: {event: valid_attributes}
        expect(response).to have_http_status(:forbidden)
      end

      after do
        sign_out
      end
    end
  end

  describe "PUT #update" do

    before do
      @event = Event.create! valid_attributes
    end

    context "when authorized" do

      before do
        sign_in :admin
      end

      context "with valid params" do
        let(:new_attributes) {
          {name: "New Name", month: 8}
        }

        it "updates the requested event" do
          put event_path(@event.id), params: {id: @event.to_param, event: new_attributes}
          @event.reload
          expect(@event.name).to eq(new_attributes[:name])
        end

        it "redirects to the event" do
          put event_path(@event.id), params: {id: @event.to_param, event: new_attributes}
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

      after do
        sign_out
      end

    end

    context "when unauthorized" do

      it "returns a unauthenticated error for no users" do
        put event_path(@event.id), params: {id: @event.to_param, event: valid_attributes}
        expect(response).to have_http_status(:unauthorized)
      end

      it "returns a permissions error for normal users" do
        sign_in :normal
        put event_path(@event.id), params: {id: @event.to_param, event: valid_attributes}
        expect(response).to have_http_status(:forbidden)
      end

      after do
        sign_out
      end
    end

    after do
      @event.destroy if @event
    end

  end

  describe "DELETE #destroy" do

    before do
      @event = Event.create! valid_attributes
    end

    context "when authorized" do

      before do
        sign_in :admin
      end

      it "destroys the requested event" do
        expect {
          delete event_path(@event.id)
        }.to change(Event, :count).by(-1)
      end

      it "redirects to the events list" do
        delete event_path(@event.id)
        expect(response).to redirect_to(events_url)
      end

      after do
        sign_out
      end

    end

    context "when unauthorized" do

      it "returns a unauthenticated error for no users" do
        delete event_path(@event.id)
        expect(response).to have_http_status(:unauthorized)
      end

      it "returns a permissions error for normal users" do
        sign_in :normal
        delete event_path(@event.id)
        expect(response).to have_http_status(:forbidden)
      end

      after do
        sign_out
        @event.destroy
      end
    end
  end

  after(:all) do
    Event.delete_all
  end


end
