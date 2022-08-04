# frozen_string_literal: true

class User < ApplicationRecord
  has_many :user_assigned_issues
  has_many :assigned_issue, through: :user_assigned_issues

  has_many :user_review_requested_pull_requests
  has_many :review_requested_pull_request, through: :user_review_requested_pull_requests
end
