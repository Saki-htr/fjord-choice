# frozen_string_literal: true

class AssignedIssue < ApplicationRecord
  has_one :raw_issue, dependent: :nullify

  has_many :user_assigned_issues, dependent: :destroy
  has_many :users, through: :user_assigned_issues
end
