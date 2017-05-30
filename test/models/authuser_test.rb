require 'test_helper'

class SessionTest < ActiveSupport::TestCase

  test "Created from auth" do
    uid = "12345"
    image_url = "http://test.com/test_image"
    user = AuthUser.from_auth uid: uid, image_url: image_url
    assert_equal uid, user.uid
    assert_equal image_url, user.image_url
  end
  
  # test "the truth" do
  #   assert true
  # end
end
