require 'rails_helper'
require 'record_extensions'
require 'fake_dataset_helper'
require 'auth_helper'

# Specs in this file have access to a helper object that includes
# the AssignmentsHelper. For example:
#
# describe AssignmentsHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe AssignmentsHelper, type: :helper do

  Profile.extend RecordExtensions
  Profile.extend FakeDataset::WithFakeDataset  
  
  include AuthHelper

  before(:all) do 
    @profiles = {admin: Profile.create!(name: "Admin User", uid: "0", roles: [:admin]),
      user1: Profile.create!(name: "User 1", uid: "1"),
      user2: Profile.create!(name: "User 2", uid: "2")
    }
  end
  
  def profile(key)
    return @profiles[key]
  end
  
  context "profile_for" do
    
    it "retrieves the profile with the given id" do
      p = profile :user1
      expect(helper.profile_for(p.id).name).to eq(p.name)
    end
  end
  
  context "name_link" do
    
    before do
      @profile = profile :user1
    end

    context "when no current user" do
      
      it "retrieves just the profile name" do
        a = Assignment.new id: 3, profile_id: @profile.id
        expect(name_link(a)).to eq(@profile.name)
      end
    end

    context "when normal user" do

      before do 
        set_session_as(@profile)
      end

      it "lists only the user for an admin assignment" do
        admin = profile :admin
        a = Assignment.new id: 3, profile_id: admin.id
        expect(name_link(a)).to eq(admin.name)
      end

      it "includes a link for the current user's profile assignment"  do
        year = 2018
        event_id = 1111
        a = Assignment.new id: 4, profile_id: @profile.id, year: year, event_id: event_id
        expect(name_link(a)).to eq(link_to @profile.name, event_user_assignments_path(event_id, year, a.id))
      end
    end

    context "when admin user" do

      before do 
        @admin = profile :admin
        set_session_as(@admin)
      end

      it "includes a link for the admin's profile assignment"  do
        year = 2017
        event_id = 2222
        a = Assignment.new id: 4, profile_id: @admin.id, year: year, event_id: event_id
        expect(name_link(a)).to eq(link_to @admin.name, event_user_assignments_path(event_id, year, a.id))
      end

      it "includes a link for other profile's assignments" do
        p = profile :user2
        year = 2016
        event_id = 3333
        a = Assignment.new id: 5, profile_id: p.id, year: year, event_id: event_id
        expect(name_link(a)).to eq(link_to p.name, event_user_assignments_path(event_id, year, a.id))
      end
    end
  end
end
