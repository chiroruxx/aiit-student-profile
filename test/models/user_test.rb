# frozen_string_literal: true

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test 'assoicated user_profile should be destroyed' do
    user = users(:one)
    assert_difference 'UserProfile.count', -1 do
      user.destroy
    end
  end
end
