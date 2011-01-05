require 'test_helper'

class SessionsControllerTest < ActionController::TestCase

  test "should get new" do
    get :new
    assert_response :success
  end

	test "should log in" do
		dave = users(:one)
		post :create, :name => dave.name, :password => dave.password
		assert_redirected_to admin_url
		assert_equal dave.id, session[:user_id]
	end

	test "should fail log" do
		dave = users(:one)
		post :create, :name => dave.name, :password => 'fail'
		assert_redirected_to login_url
	end

	test "should log out" do
		delete :destroy
		assert_redirected_to store_url
	end

end
