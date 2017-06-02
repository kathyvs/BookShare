require "rails_helper"

RSpec.describe SessionsController, type: :routing do
  describe "session routing" do

    it "routes to #destroy" do
      expect(:delete => "/sessions/1").to route_to("sessions#destroy", :id => "1")
    end

  end
end
