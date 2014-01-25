require 'test_helper'

class DashboardTest < ActionDispatch::IntegrationTest
 test "should open dasbhoard authenticated" do
 	user = create_user_and_skip_confirmation
 	post '/users/sign_in',\
 	 user: { email: user.email, password: '12345678' }
 	assert_redirected_to dashboard_path
 end

 test "should deny access whether user not are guest or major" do
 	user = create_user_with_bitmask 0
 	post_via_redirect '/users/sign_in',\
 	 user: { email: user.email, password: '12345678' }

 	get dashboard_path
 	assert_redirected_to root_path
 end
end
