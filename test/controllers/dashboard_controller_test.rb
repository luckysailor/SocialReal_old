require 'test_helper'

class DashboardControllerTest < ActionController::TestCase

 include Devise::TestHelpers

 test "should open dasbhoard index and request authentication" do
 	get :index
 	assert_redirected_to new_user_session_path
 end
end