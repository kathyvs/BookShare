require 'rails_helper'
require 'record_extensions'
require 'fake_dataset_helper'

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
  
  before(:all) do 
    @profiles = {admin: Profile.create!(name: "Admin User", uid: "0"),
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
end
