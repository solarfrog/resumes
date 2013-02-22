require 'test_helper'

class SessionsControllerTest < ActionController::TestCase
  test "should get home" do
    get :home
    assert_response :success
  end

  test "should get profile" do
    get :profile
    assert_response :success
  end

  test "should get setting" do
    get :setting
    assert_response :success
  end

  test "should get login" do
    get :login
    assert_response :success
  end

  test "should get login_attempt" do
    get :login_attempt
    assert_response :success
  end

  test "should get logout" do
    get :logout
    assert_response :success
  end

end
