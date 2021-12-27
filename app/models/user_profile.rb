# frozen_string_literal: true

class UserProfile < ApplicationRecord
  belongs_to :user, foreign_key: 'user_id', dependent: :destroy

  validates :name, presence: true, length: { maximum: 128 }
  validates :name_kana, presence: true, length: { maximum: 128 }
  validates :nickname, presence: true, length: { maximum: 128 }
  validates :email, presence: true, length: { maximum: 255 }
  validates :major_subject, presence: true, length: { maximum: 255 }
  validates :started, presence: true, length: { maximum: 4 }
  validates :work, presence: true, allow_nil: true
  validates :background, presence: true, allow_nil: true
  validates :hobby, presence: true, allow_nil: true
  validates :pbl, presence: true, length: { maximum: 128 }, allow_nil: true
  validates :favorite_food, presence: true, length: { maximum: 128 }, allow_nil: true
  validates :hated_food, presence: true, length: { maximum: 128 }, allow_nil: true
  validates :other, presence: true, allow_nil: true
end
