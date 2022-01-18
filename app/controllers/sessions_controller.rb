# frozen_string_literal: true

# SessionsController is a class that inherits from ApplicationController
class SessionsController < ApplicationController
  skip_before_action :signed_in, only: :create

  def create
    if (user = User.find_or_create_from_auth_hash(auth_hash))
      sign_in user
      return redirect_to user_profiles_path
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
