# frozen_string_literal: true

require 'test_helper'

class UserProfilesShowTest < ActionDispatch::IntegrationTest
  setup do
    OmniAuth.config.test_mode = true
    sign_in
  end

  teardown do
    OmniAuth.config.test_mode = false
  end

  test 'show full contents user' do
    if signed_in
      profile = user_profiles(:one)

      get user_profile_path(profile)

      assert_response :success
      assert_template 'user_profiles/show'

      # assert_match profile.image, @response.body
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
  end

  test 'show minimum contents user' do
    if signed_in
      profile = user_profiles(:minimum_contents)

      get user_profile_path(profile)

      assert_response :success
    end
  end

  test 'show 2 header menu items in profile show page.' do
    if signed_in
      get user_profile_path(UserProfile.last)

      assert_response :success
      assert_match '他のプロフを見る', @response.body
      assert_match 'プロフを編集する', @response.body
    end
  end
end
