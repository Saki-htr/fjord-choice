# frozen_string_literal: true

class AssignedIssue < ApplicationRecord
  has_many :user_assigned_issues, dependent: :destroy
  has_many :users, through: :user_assigned_issues

  class << self
    def total_points(user)
      AssignedIssue.where("#{user.uid} = ANY(assignees)").sum(:point)
    end

  end
end