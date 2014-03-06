require "test_helper"

class Users::RolesControllerTest < ActionController::TestCase
  include Devise::TestHelpers

	test "should get index" do
		user = create_user_with_bitmask 1
 		sign_in user
 		get :index
 		assert_response :success
 	end

 	test "should find user by email" do
		user = create_user_with_bitmask 1
		user_guest = create_user_with_profile
 		sign_in user
 		
 		post :show, role: { email: user.email }
 		assert_response :success
 	end

 	test "should redirect if user not was found" do
		user = create_user_with_bitmask 1
 		sign_in user
 		
 		post :show, role: { email: 'email@invalid.com' }
 		assert_equal "Ops! Not found!", flash[:alert][0]
 		assert_redirected_to dashboard_path
 	end

	test "should change bitmask" do
		user_admin = create_user_with_bitmask 1
		user_guest = create_user_with_profile
 		sign_in user_admin

		assert_difference("User.last.roles_mask", -30) do
			patch :update, user_id: user_guest.id, role: { bitmask: 2 }
		end

		assert_equal "Update!", flash[:notice][0]
 		assert_redirected_to dashboard_path
	end

	test "should break if the bitmask is to himself" do
		user_master = create_user_with_bitmask 2
 		sign_in user_master

		assert_no_difference("User.last.roles_mask") do
			patch :update, user_id: user_master.id, role: { bitmask: 1 }
		end
		
		assert_equal "You not can change your role.", flash[:alert][0]
 		assert_redirected_to dashboard_path
	end

	test "should deny the request if bit_mask is bigger which user requester" do
		user_master = create_user_with_bitmask 2
		user_guest = create_user_with_profile
 		sign_in user_master

		assert_no_difference("User.last.roles_mask") do
			patch :update, user_id: user_guest.id, role: { bitmask: 1 }
		end

		assert_equal "You not have permissions to do this.", flash[:alert][0]
 		assert_redirected_to dashboard_path
	end

	test "should deny if bit_mask is invalid" do
		user_master = create_user_with_bitmask 2
		user_guest = create_user_with_profile
 		sign_in user_master

		assert_no_difference("User.last.roles_mask") do
			patch :update, user_id: user_guest.id, role: { bitmask: "as" }
		end
		assert_equal "You not have permissions to do this.", flash[:alert][0]
 		assert_redirected_to dashboard_path
	end

	test "should deny if bit_mask sent is the same" do
		user_admin = create_user_with_bitmask 1
		user_master = create_user_with_bitmask 2
 		sign_in user_admin

		assert_no_difference("User.last.roles_mask") do
			patch :update, user_id: user_master.id, role: { bitmask: 2 }
		end
		assert_equal "You not have permissions to do this.", flash[:alert][0]
		assert_equal "User have the same bitmask.",\
		 assigns("user_to_be_update").errors.messages[:roles_mask][0]
 		assert_redirected_to dashboard_path
	end
end