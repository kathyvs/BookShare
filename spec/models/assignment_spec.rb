require 'rails_helper'
require 'support/database_cleaner'

RSpec.describe Assignment, type: :model do
  context "persistence" do
    it "is persisted by Mongoid" do
      expect(Profile).to be_mongoid_document
    end
  end

  context "queries" do
    
    let(:events) {
      [create(:january_event), create(:march_event), create(:may_event)]
    }
    
    let(:books) {
      [create(:parker), create(:bahlow), create(:ssno), create(:ncmj)]
    }
    
    let(:profiles) {
      [create(:profile), create(:admin)]
    }
    
    let(:years) {
      [2015, 2016, 2017, 2018]
    }
    
    context "assignments.for_year" do
      
      before do
        @assignments = {}
        events.each do |e|
          @assignments[e.name] = {}
          books.each do |b|
            @assignments[e.name][b.title] = {}
            profiles.each do |p|
              @assignments[e.name][b.title][p.name] = {}
              years.each do |y|
                assignment = Assignment.new(book: b, event: e, year: y, profile: p, count: rand(10))
                assignment.save!
                @assignments[e.name][b.title][p.name][y] ||= []
                @assignments[e.name][b.title][p.name][y] << assignment
              end
            end
          end
        end
      end
      
      it "is limited to source event" do
        events.each do |event|
          years.each do |y|
            a = event.assignments.for_year(y)
            a.each do |a|
              expect(a.event).to eq(event)
            end
            expect(a.to_a).to_not be_empty
          end
        end
      end
      
      it "is limited to given year" do
        years.each do |y|
          events.each do |event|
            a = event.assignments.for_year(y)
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
