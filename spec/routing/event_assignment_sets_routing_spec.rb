require "rails_helper"

RSpec.describe EventAssignmentSetsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/event_assignment_sets").to route_to("event_assignment_sets#index")
    end

    it "routes to #new" do
      expect(:get => "/event_assignment_sets/new").to route_to("event_assignment_sets#new")
    end

    it "routes to #show" do
      expect(:get => "/event_assignment_sets/1").to route_to("event_assignment_sets#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/event_assignment_sets/1/edit").to route_to("event_assignment_sets#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/event_assignment_sets").to route_to("event_assignment_sets#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/event_assignment_sets/1").to route_to("event_assignment_sets#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/event_assignment_sets/1").to route_to("event_assignment_sets#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/event_assignment_sets/1").to route_to("event_assignment_sets#destroy", :id => "1")
    end

  end
end
