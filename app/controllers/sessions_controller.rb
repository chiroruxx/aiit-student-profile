# frozen_string_literal: true

# SessionsController is a class that inherits from ApplicationController
class SessionsController < ApplicationController
  skip_before_action :signed_in, only: :create

  def create
    email = auth_hash.info.email
    unless email.match?(/.*@aiit.ac.jp/)
      sign_out
      return redirect_to root_path, alert: '@aiit.ac.jp ドメインのみがログイン可能です。'
    end

    if (user = User.find_or_create_from_auth_hash(auth_hash))
      sign_in user
      return redirect_to profiles_path
    end
    redirect_to root_path
  end

  def destroy
    sign_out
    redirect_to root_path
  end

  private

  def auth_hash
    request.env['omniauth.auth']
  end
end
