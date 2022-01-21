# frozen_string_literal: true

require 'test_helper'

class UserProfilesShowTest < ActionDispatch::IntegrationTest
  setup do
    OmniAuth.config.test_mode = true
  end

  teardown do
    OmniAuth.config.test_mode = false
  end

  test 'show full contents user' do
    profile = user_profiles(:one)
    sign_in_as profile.user

    get profile_path(profile)

    assert_response :success
    assert_template 'user_profiles/show'

    assert_match profile.user.image, @response.body
    assert_match profile.name, @response.body
    assert_match profile.name_kana, @response.body
    assert_match profile.nickname, @response.body
    assert_match profile.email, @response.body
    assert_match profile.major_subject, @response.body
    assert_match profile.started.to_s, @response.body
    assert_match profile.work, @response.body
    assert_match profile.background, @response.body
    assert_match profile.hobby, @response.body
    assert_match profile.pbl, @response.body
    assert_match profile.favorite_food, @response.body
    assert_match profile.hated_food, @response.body
    assert_match profile.other, @response.body

    profile.subjects.each do |subject|
      assert_match subject.name, @response.body
    end
  end

  test 'show minimum contents user' do
    profile = user_profiles(:minimum_contents)
    sign_in_as profile.user

    get profile_path(profile)

    assert_response :success
  end

  test 'show 2 header menu items in profile show page.' do
    profile = UserProfile.last
    sign_in_as profile.user

    get profile_path(profile)

    assert_response :success
    assert_match '他のプロフを見る', @response.body
    assert_match 'プロフを編集する', @response.body
  end
end
