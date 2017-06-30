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

    def copy_from_entity entity
      self.value = entity['value']
    end

  end
  
  describe "save" do
    
    context "when valid" do
      before(:all) do
        TestRecord.delete_all
        @entity = TestRecord.new
        @entity.value = 100
        @result = @entity.save
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
        @original_count= TestRecord.count
        @entity = TestRecord.new
        @entity.value = -100
        @result = @entity.save
      end

      it "returns false" do
        expect(@result).to be false
      end

      it "does not save the entity" do
        expect(@entity.id).to be_nil
        expect(TestRecord.count).to eq(@original_count)
      end

    end
  end

  describe "update" do
    
    context "when valid" do

      def old_value
        50
      end

      def new_value
        51
      end

      before(:all) do
        TestRecord.delete_all
        @entity = TestRecord.new
        @entity.value = old_value
        @entity.save
        @result = @entity.update value: new_value
      end

      it "returns true" do
        expect(@result).to be true
      end

      it "update the value in the database" do
        entity = TestRecord.find(@entity.id)
        expect(entity.value).to eq(new_value)
      end
    end
    
    context "when invalid" do

      def good_value 
        60
      end

      before(:all) do 
        @entity = TestRecord.new
        @entity.value = good_value
        @entity.save
        @result = @entity.update value: -33
      end

      it "returns false" do
        expect(@result).to be false
      end

      it "does not save the entity" do
        saved_entity = TestRecord.find(@entity.id.to_i)
        expect(saved_entity.value).to eq(good_value)
      end

    end
  end

  describe "all" do

    before(:all) do
      TestRecord.delete_all
      @values = [10, 20, 30]
      @ids = []
      @values.each do |v|
        entry = TestRecord.create! value: v
        @ids << entry.id
      end
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

  describe "find and find_or_error" do

    before(:all) do 
      @entity = TestRecord.create! value: 3
    end

    after(:all) do
      @entity.destroy
    end

    context "when id matches" do

      it "returns the saved entity" do
        expect(TestRecord.find(@entity.id).to_json).to eq(@entity.to_json)
        expect(TestRecord.find_or_error(@entity.id).to_json).to eq(@entity.to_json)
      end
    end

    context "when id does not match" do

      it "find returns nil" do
        id = @entity.id + 1
        expect(TestRecord.find(id)).to be_nil
      end

      it "find_or_error throws exception" do
        id = @entity.id + 1
        expect {TestRecord.find_or_error(id)}.to raise_error
      end

    end
  end

  describe "reload" do

    before(:all) do
      @entity1 = TestRecord.create! value: 10
      @entity2 = TestRecord.find @entity1.id
    end

    it "reloads to the saved version" do
      @entity1.update value: 30
      expect(@entity2.value).to_not be(@entity1.value)
      @entity2.reload
      expect(@entity2.value).to be(@entity1.value)
    end
  end

  describe "query" do

    before(:all) do
      TestRecord.delete_all
      @values = [10, 50, 100, 200]
      @values.each {|v| TestRecord.create! value: v}
    end

    it "returns an object that takes where clauses" do
      query = TestRecord.query
      expect(query).to respond_to(:where)
    end

    it "filters on the where clause" do
      query = TestRecord.query.where(:value, ">=", 80)
      result = query.run
      expect(result.collect {|r| r.value}).to contain_exactly(100, 200)
      result.each do |r|
        expect(r).to be_an_instance_of(TestRecord)
      end
    end

    it "returns an object that takes order clauses"

    it "returns an object that takes projection clauses"
  end
  
  after(:all) do 
    TestRecord.delete_all
  end
end
