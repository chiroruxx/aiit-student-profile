# frozen_string_literal: true

class UserProfile < ApplicationRecord
  belongs_to :user, dependent: :destroy
  has_many :user_profile_subjects, dependent: :destroy
  has_many :subjects, through: :user_profile_subjects

  validates :name, presence: true, length: { maximum: 128 }
  validates :name_kana, length: { maximum: 128 }, allow_nil: true
  validates :nickname, length: { maximum: 128 }, allow_nil: true
  validates :email, presence: true, length: { maximum: 255 }
  validates :major_subject, presence: true, length: { maximum: 255 }
  validates :started, numericality: { only_integer: true, greater_than_or_equal_to: Date.current.year - 10, 
    less_than_or_equal_to: Date.current.year + 10 }
  validates :pbl, length: { maximum: 128 }, allow_nil: true
  validates :favorite_food, length: { maximum: 128 }, allow_nil: true
  validates :hated_food, length: { maximum: 128 }, allow_nil: true
end
