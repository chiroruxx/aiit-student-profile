# frozen_string_literal: true

require 'test_helper'

class HomeControllerTest < ActionDispatch::IntegrationTest
  setup do
    OmniAuth.config.test_mode = true
  end

  teardown do
    OmniAuth.config.test_mode = false
  end

  test 'should get index' do
    get root_path
    assert_response :success
  end

  test 'should redirect to list if logged in' do
    sign_in
    get root_path
    assert_redirected_to profiles_path
  end
end
