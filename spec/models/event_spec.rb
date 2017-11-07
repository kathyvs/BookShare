require 'rails_helper'
#require 'record_extensions'
#require 'fake_dataset_helper'

RSpec.describe "Event", type: :model do
  
  context "persistence" do
    
    it "is persisted by Mongoid" do
      expect(Event).to be_mongoid_document
    end
    
  end
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

      it "name is required" do
        expect(Event.new replaced_attributes name: nil).to be_invalid
        expect(Event.new replaced_attributes name: "").to be_invalid
      end

      it "month is required" do
        expect(Event.new replaced_attributes month: nil).to be_invalid
      end

      it "month must be an integer" do
        expect(Event.new replaced_attributes month: "X").to be_invalid
        expect(Event.new replaced_attributes month: 3.5).to be_invalid
      end

      it "month must no greater than 12" do
        expect(Event.new replaced_attributes month: 13).to be_invalid
        expect(Event.new replaced_attributes month: 500).to be_invalid
      end

      it "month must be no less than 1" do
        expect(Event.new replaced_attributes month: 0).to be_invalid
        expect(Event.new replaced_attributes month: -35).to be_invalid
      end
    end

  end



end
