require "rails_helper"

RSpec.describe AssignmentSetsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/assignment_sets").to route_to("assignment_sets#index")
    end

    it "routes to #new" do
      expect(:get => "/assignment_sets/new").to route_to("assignment_sets#new")
    end

    it "routes to #show" do
      expect(:get => "/assignment_sets/1").to route_to("assignment_sets#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/assignment_sets/1/edit").to route_to("assignment_sets#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/assignment_sets").to route_to("assignment_sets#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/assignment_sets/1").to route_to("assignment_sets#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/assignment_sets/1").to route_to("assignment_sets#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/assignment_sets/1").to route_to("assignment_sets#destroy", :id => "1")
    end

  end
end
