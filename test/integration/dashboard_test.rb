require 'test_helper'
require 'capybara/rails'
 
class DashboardTest < ActionDispatch::IntegrationTest
 
 include Capybara::DSL
 test "should open dasbhoard authenticated" do
 	sign_in_as_user()
 	assert_equal dashboard_path, current_path
 end

 test "should deny access whether user not are guest or major" do
 	user_invalid = users(:user_bitmask_invalid)
 	sign_in_as_user(user_invalid)
 	# TODO
 	# When the home/index is working, we need check the message sent
 	# with alert, that the user not have permissions to do that.
 	assert_equal root_path, current_path
 end
end
