require 'test_helper'
class UserTest < ActiveSupport::TestCase
 test "should change the bitmask" do
  user = create_user

  assert_difference('user.roles_mask') do
  	change_bitmask(user, 33)
  end
 end
end