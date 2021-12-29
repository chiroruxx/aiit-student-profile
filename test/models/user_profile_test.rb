# frozen_string_literal: true

require 'test_helper'

class UserProfileTest < ActiveSupport::TestCase
  def setup
    @user_profile = user_profiles(:one)
    @subject = subjects(:one)
  end

  test 'should be valid' do
    assert @user_profile.valid?
  end

  test 'name should be present' do
    @user_profile.name = 'a' * 129
    assert_not @user_profile.valid?
  end

  test 'number of characters of name_kana should less than 128' do
    @user_profile.name_kana = 'a' * 129
    assert_not @user_profile.valid?
  end

  test 'number of characters of nickname should less than 128' do
    @user_profile.nickname = 'a' * 129
    assert_not @user_profile.valid?
  end

  test 'email should be present' do
    @user_profile.email = "#{'a' * 244}@example.com"
    assert_not @user_profile.valid?
  end

  test 'email validation should be accept valid addresses' do
    valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
                         first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
      @user_profile.email = valid_address
      assert @user_profile.valid?, "#{valid_address.inspect} should be valid"
    end
  end

  test 'major_subject should be present' do
    @user_profile.major_subject = 'a' * 256
    assert_not @user_profile.valid?
  end

  test 'started should be within year range' do
    @user_profile.started = Date.current.year - 11
    assert_not @user_profile.valid?
    @user_profile.started = Date.current.year + 11
    assert_not @user_profile.valid?
  end

  test 'number of characters of pbl should less than 128' do
    @user_profile.pbl = 'a' * 129
    assert_not @user_profile.valid?
  end

  test 'number of characters of favorite_food should less than 128' do
    @user_profile.favorite_food = 'a' * 129
    assert_not @user_profile.valid?
  end

  test 'number of characters of hated_food should less than 128' do
    @user_profile.hated_food = 'a' * 129
    assert_not @user_profile.valid?
  end

  # work, backgroud, hobby, other

  test 'assoicated profile_subjects should be destroyed' do
    @user_profile.save
    @subject.save
    @user_profile.user_profile_subjects.create!(subject_id: @subject.id)
    assert_difference 'UserProfileSubject.count', -1 do
      @user_profile.destroy
    end
  end
end
