# frozen_string_literal: true

# ApplicationController is a class that inherits from ActionController
class ApplicationController < ActionController::Base
  include SessionsHelper
  before_action :signed_in

  def signed_in
    return if current_user

    redirect_to root_path
  end
end
