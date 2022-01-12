# frozen_string_literal: true

require 'test_helper'

class UserProfilesControllerTest < ActionDispatch::IntegrationTest
  setup do
    OmniAuth.config.test_mode = true
    sign_in
  end

  teardown do
    OmniAuth.config.test_mode = false
  end

  test 'should get new' do
    get register_path
    assert_response :success
  end

  test 'should get index' do
    # TODO: should redirect login_index when not logged in
    get user_profiles_path
    user_profiles_path :success
  end

  test 'should get show' do
    get user_profile_path(UserProfile.last)
    user_profiles_path :success
  end
end
