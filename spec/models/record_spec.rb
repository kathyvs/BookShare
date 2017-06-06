require 'rails_helper'
require 'record_extensions'

RSpec.describe "ApplicationRecord", type: :model do
  
  class TestRecord extends ApplicationRecord do
    attr_accessor :value
    extend RecordExtensions

  end
  
  after do
    TestRecord.delete_all
  end
  
  describe "save" do
    
    content "when valid" do
      before do
        entity = TestRecord.new
        entity.value = 100
        @result = entity.save
      end

      it "returns true" do
        expect(@result).to be_true
      end
      it "stores the entity under the appropriate kind"
    end
    
    content "when invalid" do
      it "returns false"
    end
  end
end
