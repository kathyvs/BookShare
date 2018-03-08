require 'rails_helper'
require 'support/factory_bot'
require 'support/database_cleaner'

RSpec.describe "EventAssignmentSets", type: :request do

  before do
    @event = create(:may_event)
    create(:parker)
    create(:ssno)
  end

  def event
    expect(@event).to_not be_nil
    @event
  end

  describe "GET /events/*/event_assignment_sets/new" do

    context "when authorized" do

      before do
        sign_in :admin
      end

      context "when no set exists yet" do

        it "returns a success response" do
          get new_event_event_assignment_set_path(@event)
          expect(response).to be_success
        end

        it "renders a table containing all books" do
          get new_event_event_assignment_set_path(@event)
          expect(response.body).to include(event_path(@event))
          Book.all do |book|
            expect(response.body).to include(book.title)
          end
        end

      end

      context "when set already exists" do
        before do
          EventAssignmentSet.new(event: event).save
        end

        it "redirects to event edit" do
          get new_event_event_assignment_set_path(@event)
          expect(response).to redirect_to(edit_event_path(@event))
        end
      end

      after do
        sign_out
      end

    end

    context "when unauthorized" do

      it "returns a unauthenticated error for no users" do
        get new_event_event_assignment_set_path(@event)
        expect(response).to have_http_status(:unauthorized)
      end

      it "returns a permissions error for normal users" do
        sign_in :normal
        get new_event_event_assignment_set_path(@event)
        expect(response).to have_http_status(:forbidden)
      end

      after do
        sign_out
      end
    end
  end

end
