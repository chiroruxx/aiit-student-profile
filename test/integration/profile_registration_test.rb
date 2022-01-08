# frozen_string_literal: true

require 'test_helper'

class ProfileRegistrationTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:no_profile)
  end

  test 'unsuccessful registration' do
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
    # login and do not have user_profile
    get register_path
    assert_template 'user_profiles/new'
    image = fixture_file_upload('test/fixtures/account_box.png', 'image/png')
    assert_difference 'UserProfile.count', 1 do
      post user_profiles_path, params: {
        user_profile: {
          name: 'man',
          email: 'man@man.com',
          major_subject: '情報アーキテクチャ',
          started: '2021',
          image: image
        }
      }
    end
    # assert @user.user_profile.image.attached?
    assert User.last.user_profile.image.attached?
    assert_redirected_to user_profiles_path
  end
end
