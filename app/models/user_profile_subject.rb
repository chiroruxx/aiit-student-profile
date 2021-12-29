# frozen_string_literal: true

class UserProfileSubject < ApplicationRecord
  belongs_to :user_profile
  belongs_to :subject
end
