require 'test_helper'
class UserTest < ActiveSupport::TestCase
  test "a bitmask should not can be invalid" do
   	user = create_user
    user.roles_mask=0
    assert_not user.valid?
    assert_equal 'is invalid', user.errors.messages[:roles_mask][0]
  end

  test "should change the user bitmask" do
    user = create_user

    assert_difference('user.roles_mask', -16) do
    	user.roles_mask=16
    	user.save!
    end
   end
  end