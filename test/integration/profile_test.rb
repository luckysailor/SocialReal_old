require 'test_helper'
require 'capybara/rails'
 
class ProfilesTest < ActionDispatch::IntegrationTest
 
 include Capybara::DSL

 setup do
 	@profile = profiles(:one)
 end

 test "should create profile if user have not profile" do
 	user = create_user_without_profile
 	sign_in_as_user(user)

 	assert_equal new_profile_path, current_path

 	fill_in 'profile_name', :with => @profile.name
 	fill_in 'profile_email', :with => @profile.email
 	fill_in 'profile_location', :with => @profile.location
 	fill_in 'profile_language', :with => @profile.language
 	fill_in 'profile_favorite_topics', :with => @profile.favorite_topics
 	fill_in 'profile_my_articles', :with => @profile.my_articles
 	fill_in 'profile_my_softwares_client', :with => @profile.my_softwares_client
  click_on 'Create Profile'

  assert_equal profile_path(user.profile), current_path
 end

 test "should raise error if image is bigger than 1mb" do
  CarrierWave.configure do |config|
    config.enable_processing = false
  end
 	user = create_user_without_profile
 	sign_in_as_user(user)
 	
 	assert_equal new_profile_path, current_path

 	fill_in 'profile_name', :with => @profile.name
 	fill_in 'profile_email', :with => @profile.email
 	attach_file('profile_picture', "#{Rails.root}/public/image_1mb.png")

  click_on 'Create Profile'

  assert page.has_content?('Picture should be less than 1MB')
  assert_equal profiles_path, current_path
 end
end
