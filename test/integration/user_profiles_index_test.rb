# frozen_string_literal: true

require 'test_helper'

class UserProfilesIndexTest < ActionDispatch::IntegrationTest
  setup do
    OmniAuth.config.test_mode = true
    sign_in
    @user_profile = user_profiles(:next_page_user)
  end

  teardown do
    OmniAuth.config.test_mode = false
  end

  test 'show user list' do
    # login and do not have user_profile
    if signed_in?
      get profiles_path
      assert_equal 200, status
      assert_template 'user_profiles/index'
      # max_per_page 10
      assert_select 'ul.users > li', count: 10
      10.times do |i|
        assert_select 'span.username', text: user_profiles[i].name
        assert_select 'span.major_subject_name', text: user_profiles[i].major_subject
        assert_select 'span.other', text: user_profiles[i].other.truncate(200) if user_profiles[i].other.present?
        next unless user_profiles[i].image.present?

        assert_select 'img' do
          assert_select '[src=?]', user_profiles[i].image
        end
      end
    end
  end

  test 'pagination test' do
    profile = user_profiles(:next_page_user)
    get profiles_path
    assert_not @response.body.include? profile.name
  end

  test 'index including pagination' do
    get profiles_path
    assert_template 'user_profiles/index'
    assert_select 'nav.pagination'
  end

  test 'header links' do
    get profiles_path
    if signed_in?
      assert_select 'a[href=?]', profiles_path
      assert_select 'a[href=?]', profiles_edit_path
    end
  end
end
