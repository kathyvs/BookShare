require 'rails_helper'
require 'record_extensions'
require 'fake_dataset_helper'

RSpec.describe "Event", type: :model do
  
  context "when initializing" do

    let(:valid_attributes) {
      {name: "Test", month: 8}
    }

    def replaced_attributes(attrs)
      valid_attributes.merge(attrs)
    end

    it "converts dates to month" do
      month = 5
      event = Event.new(replaced_attributes month: Date.new(2017, month))
      expect(event.month).to eq(month)
    end
    
    context "when validating" do

      it "default attributes are valid" do
        expect(Event.new valid_attributes).to be_valid
      end

    end

  end



end
