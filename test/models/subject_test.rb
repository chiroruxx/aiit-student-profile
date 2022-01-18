# frozen_string_literal: true

require 'test_helper'

class SubjectTest < ActiveSupport::TestCase
  test 'assoicated user_profile_subject should be destroyed' do
    subject = subjects(:one)
    assert_difference 'UserProfileSubject.count', -1 do
      subject.destroy
    end
  end
end
