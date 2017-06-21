require 'rails_helper'
require 'record_extensions'
require 'fake_dataset_helper'

# Specs in this file have access to a helper object that includes
# the SessionsHelper. For example:
#
# describe SessionsHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe ApplicationHelper, type: :helper do
  
  Profile.extend RecordExtensions
  Profile.extend FakeDataset::WithFakeDataset

  describe "log in help" do
    context "When logged in" do

      let(:user) {
        AuthUser.new "12345", "http://test.com"
      }
      before do 
        session[:user] = Marshal.dump user
      end
      
      it "logged_in? is true" do
        expect(helper).to be_logged_in
      end

      it "current user matches user"  do
        cur_user = helper.current_user
        expect(cur_user.uid).to eq(user.uid)
      end

      context "When profile exists" do

        before do
          @profile = Profile.create! uid: user.uid, name: "Test"
          session[:profile_id] = @profile.id
        end

        it "fetches profile" do
          cur_user = helper.current_user
          expect(cur_user.profile.name).to eq(@profile.name)
        end
      end
    end
  end
end
