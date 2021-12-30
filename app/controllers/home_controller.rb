# frozen_string_literal: true

# HomeController is a class that inherits from ApplicationController
class HomeController < ApplicationController
  skip_before_action :signed_in, only: :index
  def index; end
end
