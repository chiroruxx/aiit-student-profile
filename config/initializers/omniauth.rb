# frozen_string_literal: true

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2,
           Rails.application.credentials.google[:client_id],
           Rails.application.credentials.google[:client_secret], {
             provider_ignores_state: true
           }
end
OmniAuth.config.allowed_request_methods = %i[get]
