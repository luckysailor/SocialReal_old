require 'test_helper'

class ProfileDecoratorTest < Draper::TestCase
	
	test "should return link to edit profile" do
		profile = profiles(:one)
		profile = profile.decorate(context: {current_user_can_edit?: true})
		assert_equal profile.edit_profile, "<p class=\"box-title\"><a href=\"/profiles/#{profile.id}/edit\">Edit</a></p>"
	end
end
