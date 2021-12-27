# frozen_string_literal: true

# Controller for create and edit UserProfile
class UserProfilesController < ApplicationController
  before_action :set_major, only: %i[new edit]
  # before_action ...

  def new
    @user = User.new
    # @user_profile = current_user.build_user_profile
    @user_profile = @user.build_user_profile
  end

  def create
    @user = User.new
    @user.save
    # @user_profile = current_user.build_user_profile(profile_params)
    @user_profile = @user.build_user_profile(profile_params)
    @user_profile.save
    # if @user_profile.save
    #   render '...'
    # else
    #   render 'new'
    # end
  end

  def edit; end

  def update; end

  private

  def profile_params
    params.require(:user_profile).permit(
      :name, :name_kana, :nickname, :email,
      :major_subject, :started, :work, :background, :pbl,
      :hobby, :favorite_food, :hated_food, :other
    )
  end

  def set_major
    @major_subject = %w[事業設計工学 情報アーキテクチャ 創造技術]
  end
end
