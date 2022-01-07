# frozen_string_literal: true

require 'test_helper'

class ProfileRegistrationTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:three)
  end

  test 'unsuccessful registration' do
    # login and do not have user_profile
    get register_path
    assert_template 'user_profiles/new'
    assert_no_difference 'UserProfile.count' do
      post user_profiles_path, params: {
        user_profile: {
          user_id: 3,
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
    # login and do not have user_profile
    get register_path
    assert_template 'user_profiles/new'
    assert_difference 'UserProfile.count', 1 do
      post user_profiles_path, params: {
        user_profile: {
          user_id: 3,
          name: 'man',
          email: 'man@man.com',
          major_subject: '情報アーキテクチャ',
          started: '2021'
        }
      }
    end
    assert_redirected_to user_profiles_path
  end
end
