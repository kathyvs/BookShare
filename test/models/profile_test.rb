require 'test_helper'
require 'active_model/lint'
class ProfileTest < ActiveSupport::TestCase
  
  def setup
    @model = Profile.new(uid: '111', name: 'test')
  end
  
  include ActiveModel::Lint::Tests
  
  # test "the truth" do
  #   assert true
  # end
end
