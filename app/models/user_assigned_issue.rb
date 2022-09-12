# frozen_string_literal: true

class UserAssignedIssue < ApplicationRecord
  belongs_to :user
  belongs_to :assigned_issue

  validates :user_id, uniqueness: { scope: :assigned_issue_id }
end
