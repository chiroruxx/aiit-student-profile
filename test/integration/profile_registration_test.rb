# frozen_string_literal: true

require 'test_helper'

class ProfileRegistrationTest < ActionDispatch::IntegrationTest
  setup do
    OmniAuth.config.test_mode = true
  end

  teardown do
    OmniAuth.config.test_mode = false
  end

  test 'should redirect register when not signed in' do
    sign_out
    get register_path
    assert_not signed_in?
    assert_redirected_to root_path
  end

  test 'unsuccessful registration' do
    sign_in
    # login and do not have user_profile
    get register_path
    assert_template 'user_profiles/new'
    assert_no_difference 'UserProfile.count' do
      post user_profiles_path, params: {
        user_profile: {
          name: '',
          email: '',
          major_subject: '',
          started: ''
        }
      }
    end
    assert_template 'user_profiles/new'
  end

  test 'successful registration' do
    sign_in
    # login and do not have user_profile
    get register_path
    assert_template 'user_profiles/new'
    assert_difference 'UserProfile.count', 1 do
      post user_profiles_path, params: {
        user_profile: {
          name: 'mockuser',
          email: 'mock@example.com',
          major_subject: '情報アーキテクチャ',
          started: '2021'
        }
      }
    end
    assert_redirected_to user_profiles_path
  end
end
