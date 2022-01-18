# frozen_string_literal: true

require 'test_helper'

class LoginTest < ActionDispatch::IntegrationTest
  setup do
    OmniAuth.config.test_mode = true
    Rails.application.env_config['omniauth.auth'] = nil
    setup_omniauth_mock
    Rails.application.env_config['omniauth.auth'] = OmniAuth.config.mock_auth[:google_oauth2]
  end

  teardown do
    OmniAuth.config.test_mode = false
  end

  test 'login flow' do
    get root_path
    assert_response :success

    post '/auth/google_oauth2'
    assert_response :redirect
    assert_redirected_to '/auth/google_oauth2/callback'

    follow_redirect!
    assert_response :redirect
    assert_redirected_to user_profiles_path

    follow_redirect!
    assert_response :success
  end
end
