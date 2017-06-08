require 'rails_helper'
require 'record_extensions'

RSpec.describe "ApplicationRecord", {:type => :model} do
  
  class TestRecord < ApplicationRecord 
    attr_accessor :value
    extend RecordExtensions

    def add_entity_data(entity)
      entity["value"] = value
    end

    def valid?
      return value > 0
    end

    def self.from_entity entity
      record = TestRecord.new
      record.id = entity.key.id
      record.value = entity['value']
      record
    end

  end
  
  describe "save" do
    
    context "when valid" do
      before(:all) do
        @entity = TestRecord.new
        @entity.value = 100
        @result = @entity.save
      end

      after(:all) do
        TestRecord.delete_all
      end

      it "returns true" do
        expect(@result).to be true
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
      before(:each) do 
        @entity = TestRecord.new
        @entity.value = -100
        @result = @entity.save
      end

      it "returns false" do
        expect(@result).to be false
      end

      it "does not save the entity" do
        expect(@entity.id).to be_nil
        expect(TestRecord.all).to be_empty
      end

    end
  end

  describe "all" do

    before(:all) do
      @values = [10, 20, 30]
      @ids = []
      @values.each do |v|
        entry = TestRecord.create! value: v
        @ids << entry.id
      end
    end

    after(:all) do
      TestRecord.delete_all
    end

    it "retrieves all entities" do
      entries = TestRecord.all
      expect(entries.map {|e| e.value}).to contain_exactly(*@values)
      expect(entries.map {|e| e.id}).to contain_exactly(*@ids)
    end
  end

  describe "destroy" do

    before(:each) do
      @entity = TestRecord.create! value: 50
    end

    it "removes from database" do
      id = @entity.id
      @entity.destroy
      expect(TestRecord.find(id)).to be_nil
    end
  end

  describe "find" do

    before(:all) do 
      @entity = TestRecord.create! value: 3
    end

    after(:all) do
      @entity.destroy
    end

    context "when id matches" do

      it "returns the saved entity" do
        expect(TestRecord.find(@entity.id).to_json).to eq(@entity.to_json)
      end
    end

    context "when id does not match" do

      it "returns nil" do
        id = @entity.id + 1
        expect(TestRecord.find(id)).to be_nil
      end
    end
  end

end
