# frozen_string_literal: true

# HomeController is a class that inherits from ApplicationController
class HomeController < ApplicationController
  layout 'full'
  skip_before_action :signed_in, only: :index

  def index
    redirect_to user_profiles_path if current_user
  end
end
