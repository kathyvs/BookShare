require 'rails_helper'
require 'record_extensions'

RSpec.describe "ApplicationRecord", type: :model do
  
  class TestRecord < ApplicationRecord 
    attr_accessor :value
    extend RecordExtensions

    def add_entity_data(entity)
      entity["value"] = value
    end

  end
  
  after do
    TestRecord.delete_all
  end
  
  describe "save" do
    
    context "when valid" do
      before do
        entity = TestRecord.new
        entity.value = 100
        @result = entity.save
      end

      it "returns true" do
        expect(@result).to be true
      end
      it "stores the entity under the appropriate kind"
    end
    
    context "when invalid" do
      it "returns false"
    end
  end
end
