# docker-compose run -e EDITOR=vim web rails credentials:edit -e development
# frozen_string_literal: true

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2,
           Rails.application.credentials.google[:client_id],
           Rails.application.credentials.google[:client_secret]
end
OmniAuth.config.allowed_request_methods = %i[get]
