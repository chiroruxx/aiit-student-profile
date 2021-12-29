# frozen_string_literal: true

class Subject < ApplicationRecord
  has_many :user_profile_subjects
  has_many :user_profile, through: :user_profile_subjects
end
