# frozen_string_literal: true

# Controller for create and edit UserProfile
class UserProfilesController < ApplicationController
  before_action :set_info, only: %i[edit update]
  before_action :signed_in, only: %i[index show edit update]

  def index
    @user_profiles = UserProfile.all.page(params[:page])
  end

  def show
    @profile = UserProfile.find(params[:id])
  end

  def edit
    if current_user.profile_registered?
      @user_profile = current_user.user_profile
    else
      @user_profile = current_user.build_user_profile
      @user_profile.name = current_user.name
      @user_profile.email = current_user.email
    end
    @user_profile.image = current_user.image
  end

  def update
    @user_profile = current_user_profile
    @user_profile.assign_attributes profile_params
    @user_profile.image = current_user.image

    if @user_profile.save
      redirect_to profile_path @user_profile
    else
      render 'edit'
    end
  end

  private

  def profile_params
    params.require(:user_profile).permit(
      :name, :name_kana, :nickname, :email,
      :major_subject, :started, :work, :background, :pbl,
      :hobby, :favorite_food, :hated_food, :other,
      subject_ids: []
    )
  end

  def set_info
    @major_subject = %w[事業設計工学 情報アーキテクチャ 創造技術]
    @subjects = Subject.all
  end

  def current_user_profile
    current_user.profile_registered? ? current_user.user_profile : current_user.build_user_profile
  end
end
