# frozen_string_literal: true

require 'test_helper'

class UserProfilesControllerTest < ActionDispatch::IntegrationTest
  setup do
    OmniAuth.config.test_mode = true
  end

  teardown do
    OmniAuth.config.test_mode = false
  end

  test 'should get new' do
    sign_in
    if signed_in?
      get register_path
      assert_response :success
    end
  end

  test 'should get index' do
    sign_in
    if signed_in?
      get user_profiles_path
      user_profiles_path :success
    end
  end

  test 'should get show' do
    profile = UserProfile.last
    sign_in_as profile.user

    get user_profile_path(profile)
    user_profiles_path :success
  end

  test 'redirect if not logged in' do
    get user_profile_path(UserProfile.last)

    assert_redirected_to root_path
  end

  test 'assoicated user_profile should be destroyed' do
    user = users(:one)
    assert_difference 'UserProfile.count', -1 do
      user.destroy
    end
  end
end
