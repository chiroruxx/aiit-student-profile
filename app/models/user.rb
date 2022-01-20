# frozen_string_literal: true

# User is a class that inherits from ApplicationRecord
class User < ApplicationRecord
  has_one :user_profile, dependent: :destroy
  class << self
    def find_or_create_from_auth_hash(auth_hash)
      user_params = user_params_from_auth_hash(auth_hash)
      User.find_or_create_by(provider: user_params[:provider], uid: user_params[:uid]) do |user|
        user.update(user_params)
      end
    end

    private

    def user_params_from_auth_hash(auth_hash)
      {
        name: auth_hash.info.name,
        provider: auth_hash.provider,
        uid: auth_hash.uid,
        email: auth_hash.info.email,
        image: auth_hash.info.image
      }
    end
  end

  def profile_registered?
    !user_profile.nil?
  end
end
