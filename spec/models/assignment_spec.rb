require 'rails_helper'
require 'support/factory_bot'

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
      [create(:user), create(:admin)]
    }
    context "all_for" do
      
#      before do
#        @assignments = {}
#        events.each do |e|
#          @assignments[e.name] = {}
#          books.each do |b|
#            @assigments[e.name][b.title] = {}
#            profiles.each do |p|
#              @assignments[e.name][b.title][p.name] = []
#              assignment = Assignment.new(book: book, event: event, profile: profile, count: rand(10))
#              @assignments[e.name][b.title][p.name] << assignment
#            end
#          end
#        end
#      end
      it "uses event in query" do
        expect(events).to eq(3)
      end
      
      it "uses year in query"
    end
  end

end
