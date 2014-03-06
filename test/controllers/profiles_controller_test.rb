require 'test_helper'

class ProfilesControllerTest < ActionController::TestCase
  include Devise::TestHelpers
  
  setup do
    @profile = profiles(:one)

    @user = create_user_with_profile
    sign_in @user
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:profiles)
  end

  test "should get new" do
    user = create_user_without_profile
    sign_in user

    get :new
    assert_response :success
  end

  test "should create profile" do
    user = create_user_without_profile
    sign_in user
    get :new
    
    assert_difference('Profile.count') do
      post :create, profile: { email: @profile.email, favorite_topics: @profile.favorite_topics, hidden: @profile.hidden, language: @profile.language, location: @profile.location, my_articles: @profile.my_articles, my_softwares_client: @profile.my_softwares_client, name: @profile.name, picture: @profile.picture }
    end
    assert_redirected_to profile_path(assigns(:profile))
  end

  test "should show profile" do
    get :show, id: @user.profile.id
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @user.profile.id
    assert_response :success
  end

  test "should update profile" do
    patch :update, id: @user.profile.id, profile: { email: @profile.email, favorite_topics: @profile.favorite_topics, hidden: @profile.hidden, language: @profile.language, location: @profile.location, my_articles: @profile.my_articles, my_softwares_client: @profile.my_softwares_client, name: @profile.name, picture: @profile.picture }
    assert_redirected_to profile_path(assigns(:profile))
  end
end
