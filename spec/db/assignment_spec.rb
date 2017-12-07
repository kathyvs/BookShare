require 'rails_helper'
require 'record_extensions'

RSpec.describe "Assignment", {:type => :model} do
  
  Assignment.extend RecordExtensions
  
  let(:attrs) do
    {event_id: 5555, year: 2015, profile_id: 1600, bringing: {21 => 1, 22 => 2}}
  end
  
  context "on round-trip" do

    before do
      Assignment.delete_all
    end

    it "recreates all attributes" do
      assignment = Assignment.create! attrs

      reload = Assignment.find assignment.id
      attrs.each do |attr, value|
        expect(reload.send(attr)).to eq(value)
      end
    end
  end

  context "for all_for" do

    attr_accessor :assignment_map
    before(:all) do
      Assignment.delete_all
      event_ids = [501, 502, 501, 502]
      years = [2017, 2017, 2018, 2019]
      profiles = [[1, 2, 3], [4, 5], [6, 7], [8]]
      @assignment_map = {}
      event_ids.zip(years, profiles).each do |e, y, plist|
        @assignment_map[e] ||= {}
        @assignment_map[e][y] = plist
        plist.each do |p|
          Assignment.create! event_id: e, year: y, profile_id: p, bringing: {}
        end
      end
    end

    context "without profile" do

      it "retrieves all profiles for the given event and year" do
        assignment_map.keys.each do |e|
          assignment_map[e].keys.each do |y|
            actual_pids = Assignment.all_for(e, y).map {|a| a.profile_id}
            expect(actual_pids).to contain_exactly(*assignment_map[e][y])
          end
        end
      end
    end
  end

  after(:all) do 
    Assignment.delete_all
  end  
end