# frozen_string_literal: true

class AssignedIssue < ApplicationRecord
  belongs_to :raw_issue, dependent: :nullify

  has_many :user_assigned_issues, dependent: :destroy
  has_many :users, through: :user_assigned_issues
end
