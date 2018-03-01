require "rails_helper"

RSpec.describe AssignmentSetsController, type: :routing do
  describe "routing" do

    it "requires event and year for index" do
      expect(:get => "/events/3/2018/assignments").to route_to(
        "assignment_sets#index",
        :event_id => "3",
        :year => "2018")
    end

    it "requires event and year and id for show" do
      expect(:get => "/events/2/2017/assignments/1").to route_to(
        "assignment_sets#show",
        :id => "1",
        :event_id => "2",
        :year => "2017")
    end

  end
end
