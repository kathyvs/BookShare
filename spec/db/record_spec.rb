require 'rails_helper'
require 'record_extensions'

RSpec.describe "ApplicationRecord", type: :model do
  
  class TestRecord < ApplicationRecord 
    attr_accessor :value
    extend RecordExtensions

    def add_entity_data(entity)
      entity["value"] = value
    end

    def valid?
      return value > 0
    end

  end
  
  after do
    TestRecord.delete_all
  end
  
  describe "save" do
    
    context "when valid" do
      before do
        @entity = TestRecord.new
        @entity.value = 100
        @result = @entity.save
      end

      it "returns true" do
        expect(@result).to be true
      end

      it "sets the id" do
        puts @entity.id.to_json

        expect(@entity.id).to be_truthy
      end
      it "stores the entity under the appropriate kind" do
        key = Google::Cloud::Datastore::Key.new "TestRecord", @entity.id.to_i
        entities = TestRecord.dataset.lookup key
        expect(entities.size).to be 1
        entity = entities.first
        expect(entity["value"]).to eq(@entity.value)
      end
    end
    
    context "when invalid" do
      it "returns false"
    end
  end
end
