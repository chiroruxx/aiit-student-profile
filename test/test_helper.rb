# frozen_string_literal: true

ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'

module ActiveSupport
  class TestCase
    # Run tests in parallel with specified workers
    parallelize(workers: :number_of_processors)

    # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
    fixtures :all

    # Add more helper methods to be used by all tests here...
    def create_omniauth_mock_for(user)
      OmniAuth::AuthHash.new({
                               provider: user.provider,
                               uid: user.uid,
                               email: user.email,
                               info: {
                                 name: user.name,
                                 image: user.image
                               }
                             })
    end

    def setup_omniauth_mock
      OmniAuth.config.mock_auth[:google_oauth2] = OmniAuth::AuthHash.new({
                                                                           provider: 'google_oauth2',
                                                                           uid: '12345678910',
                                                                           email: 'mock@example.com',
                                                                           info: {
                                                                             name: 'mockuser',
                                                                             image: 'https://test.com/test.png'
                                                                           }
                                                                         })
    end

    def sign_in
      Rails.application.env_config['omniauth.auth'] = nil
      setup_omniauth_mock
      Rails.application.env_config['omniauth.auth'] = OmniAuth.config.mock_auth[:google_oauth2]
    end

    def sign_in_as(user)
      OmniAuth.config.mock_auth[:google_oauth2] = create_omniauth_mock_for user
      Rails.application.env_config['omniauth.auth'] = create_omniauth_mock_for user
      get '/auth/google_oauth2/callback'
    end

    def signed_in?
      !Rails.application.env_config['omniauth.auth'].nil?
    end
  end
end
