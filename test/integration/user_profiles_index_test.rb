# frozen_string_literal: true

require 'test_helper'

class UserProfilesIndexTest < ActionDispatch::IntegrationTest
  setup do
    OmniAuth.config.test_mode = true
    sign_in
  end

  teardown do
    OmniAuth.config.test_mode = false
  end

  test 'show user list' do
    # login and do not have user_profile
    if signed_in
      get user_profiles_path
      assert_equal 200, status
      assert_template 'user_profiles/index'
      assert_select 'ul.users > li', count: user_profiles.count
      user_profiles.each do |user|
        assert_select 'span.username', text: user.name
        assert_select 'span.major_subject_name', text: user.major_subject
        assert_select 'span.other', text: user.other.truncate(200) if user.other.present?
      end
    end
  end

  test 'header links' do
    get user_profiles_path
    get register_path
    get sign_out_path
    if signed_in
      assert_select 'a[href=?]', user_profiles_path
      assert_select 'a[href=?]', register_path
      assert_select 'a[href=?]', sign_out_path
    end
  end
end
