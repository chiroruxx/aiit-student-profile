# frozen_string_literal: true

require 'test_helper'

class SessionControllerTest < ActionDispatch::IntegrationTest
  setup do
    OmniAuth.config.test_mode = true
  end

  teardown do
    OmniAuth.config.mock_auth[:google_oauth2] = nil
    OmniAuth.config.test_mode = false
  end

  test 'Redirect when create session' do
    setup_mock

    get '/auth/:provider/callback'

    assert_redirected_to profiles_path
  end

  test 'Redirect when invalid email' do
    user = {
      provider: 'google_oauth2',
      uid: '9999999999',
      name: 'mockuser',
      email: 'mock@example.com',
      image: 'https://test.com/test.png'
    }

    setup_mock User.new(user)

    get '/auth/:provider/callback'

    assert_redirected_to root_path
  end

  test 'Save user data if user have not logged in' do
    # clean up
    User.find_by(provider: 'google_oauth2', uid: '9999999999', &:destroy)

    user = new_user({
                      provider: 'google_oauth2',
                      uid: '9999999999'
                    })
    setup_mock user

    get '/auth/:provider/callback'

    assert_same true, User.exists?(provider: 'google_oauth2', uid: '9999999999')
  end

  test 'Does not save user data if user have logged in' do
    # clean up
    User.find_by(provider: 'google_oauth2', uid: '9999999999', &:destroy)

    user = new_user({
                      provider: 'google_oauth2',
                      uid: '9999999999'
                    })
    user.save
    setup_mock user

    get '/auth/:provider/callback'

    assert_same 1, User.where(provider: 'google_oauth2', uid: '9999999999').count
  end

  test 'Set session when create session' do
    setup_mock

    get '/auth/:provider/callback'

    assert_same User.last.id, session[:user_id]
  end

  test 'Redirect when destroy session' do
    sign_in

    get '/sign_out'

    assert_redirected_to root_path
  end

  test 'Unset session when destroy session' do
    sign_in

    get '/sign_out'

    assert_same nil, session[:user_id]
  end

  private

  def setup_mock(user = nil)
    user = new_user if user.nil?

    OmniAuth.config.mock_auth[:google_oauth2] = create_omniauth_mock_for user
    Rails.application.env_config['omniauth.auth'] = create_omniauth_mock_for user
  end

  def new_user(overrides = nil)
    attributes = {
      provider: 'google_oauth2',
      uid: '9999999999',
      name: 'mockuser',
      email: 'mock@aiit.ac.jp',
      image: 'https://test.com/test.png'
    }

    attributes.merge(overrides) unless overrides.nil?

    User.new(attributes)
  end
end
