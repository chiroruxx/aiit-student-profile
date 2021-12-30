# frozen_string_literal: true

# User is a class that inherits from ApplicationRecord
class User < ApplicationRecord
  class << self
    def find_or_create_from_auth_hash(auth_hash)
      user_params = user_params_from_auth_hash(auth_hash)
      find_or_create_by(uid: user_params[:uid]) do |user|
        user.update(user_params)
      end
    end

    private

    def user_params_from_auth_hash(auth_hash)
      {
        name: auth_hash.info.name,
        provider: auth_hash.provider,
        uid: auth_hash.uid,
        image: auth_hash.info.image
      }
    end
  end
end
