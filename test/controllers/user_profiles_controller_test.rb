# frozen_string_literal: true

require 'test_helper'

class UserProfilesControllerTest < ActionDispatch::IntegrationTest
  test 'should get new' do
    get register_path
    assert_response :success
  end
end
