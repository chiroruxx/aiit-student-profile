# frozen_string_literal: true

# Controller for create and edit UserProfile
class UserProfilesController < ApplicationController
  before_action :set_info, only: %i[new create edit]
  before_action :signed_in, only: %i[index new create show edit update]
  # before_action ... , only: %i[edit update] # correct user?

  def index
    @user_profiles = UserProfile.all.page(params[:page])
  end

  def new
    @user_profile = current_user.build_user_profile
    @user_profile.name = current_user.name
    if current_user.profile_registered?
      redirect_to user_profiles_path # temp
    end
  end

  def create
    @user_profile = current_user.build_user_profile(profile_params)
    if @user_profile.save
      redirect_to user_profiles_path
    else
      render 'new'
    end
  end

  def show
    @profile = UserProfile.find(params[:id])
  end

  def edit
    if current_user.profile_registered?
      @user_profile = current_user.user_profile
    else
      redirect_to register_path
    end
  end

  def update; end

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
end
