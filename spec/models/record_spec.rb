require 'rails_helper'
require 'record_extensions'
require 'fake_dataset_helper'

RSpec.describe "ApplicationRecord", type: :model do
  
  class TestRecord extends ApplicationRecord do
    extend RecordExtensions

  end
  
  after do
  end
  
  describe "save" do
    
    content "when valid" do
      it "returns     
    end
    
    it "succeeds (even without authentication)" do
      pending "A valid all method"
       
      get events_path
      expect(response).to have_http_status(200)
    end

    it "display all events"

    it "marks the next event"

  end
end
