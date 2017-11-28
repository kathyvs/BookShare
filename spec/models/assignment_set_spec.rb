require 'rails_helper'

RSpec.describe AssignmentSet, type: :model do

  context "persistence" do
    it "is persisted by Mongoid" do
      expect(Profile).to be_mongoid_document
    end
  end

  context "queries" do
    
    let(:events) {
      [create(:january_event), create(:march_event), create(:may_event)]
    }
    
    let(:profiles) {
      [create(:profile), create(:admin)]
    }
    
    let(:years) {
      [2015, 2016, 2017, 2018]
    }
    
    context "assignment_sets.for_year" do
      
      before do
        @assignment_sets = {}
        events.each do |e|
          @assignment_sets[e.name] = {}
          years.each do |y|
            @assignment_sets[e.name][y] = Set.new
            profiles.each do |p|
              assignment_set = AssignmentSet.new(event: e, year: y, profile: p)
              assignment_set.save!
              @assignment_sets[e.name][y] << assignment_set
            end
          end
        end
      end
      
      it "is limited to source event" do
        events.each do |event|
          years.each do |y|
            aset = event.assignment_sets.for_year(y)
            aset.each do |a|
              expect(a.event).to eq(event)
            end
            expect(aset.to_set).to eq(@assignment_sets[event.name][y].to_set)
          end
        end
      end
      
      it "is limited to given year" do
        years.each do |y|
          events.each do |event|
            a = event.assignment_sets.for_year(y)
            a.each do |a|
              expect(a.year).to eq(y)
            end
            expect(a.to_a).to_not be_empty
          end
        end
      end
    end
  end
end
