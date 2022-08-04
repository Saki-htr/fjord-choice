# frozen_string_literal: true

class UserAssignedIssue < ApplicationRecord
  belongs_to :user
  belongs_to :assigned_issue
end
