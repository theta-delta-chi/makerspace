require 'test_helper'

class ContactsControllerTest < ActionController::TestCase
  test "should get set" do
    get :set
    assert_response :success
  end

  test "should get get" do
    get :get
    assert_response :success
  end

end
