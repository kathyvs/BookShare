require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest
  
  test "create when profile exists" do
    uid = "33333"
    image_url = "http://test.com/test_image"
    post sessions_url, env: {"omniauth.auth" => {uid: uid, image_url: image_url}}

    follow_redirect!
    
    assert_response :success
    assert_equal uid, session[:user].uid
  end

  test "create when profile does not exist" do
    uid = "44444"
    image_url = "http://test.com/test_image2"
    post sessions_url, env: {"omniauth.auth" => {uid: uid, image_url: image_url}}

    follow_redirect!
    
    assert_response :success
    assert_equal uid, session[:user].uid
    assert_equal image_url, session[:user].image_url
    assert_nil session[:user].profile
  end

  # test "the truth" do
  #   assert true
  # end
end
