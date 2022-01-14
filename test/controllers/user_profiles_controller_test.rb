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
    if signed_in?
      get register_path
      assert_response :success
    end
  end

  test 'should get index' do
    if signed_in?
      get user_profiles_path
      user_profiles_path :success
    end
  end

  test 'should get show' do
    if signed_in?
      get user_profile_path(UserProfile.last)
      user_profiles_path :success
    end
  end
end
