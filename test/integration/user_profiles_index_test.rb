# frozen_string_literal: true

require 'test_helper'

class UserProfilesIndexTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:three)
    @user_profile = user_profiles(:three)
  end

  test 'show user list' do
    # login and do not have user_profile
    get user_profiles_path
    assert_equal 200, status
    assert_template 'user_profiles/index'
    assert_select 'ul.users > li', count: user_profiles.count
    user_profiles.each do |user|
      assert_select 'span.username', text: user.name
      assert_select 'span.major_subject_name', text: user.major_subject
      assert_select 'span.other', text: user.other.truncate(200)
    end
  end

  test 'hedder links' do
    get user_profiles_path
    assert_select 'a[href=?]', user_profiles_path
    assert_select 'a[href=?]', register_path
  end
end
