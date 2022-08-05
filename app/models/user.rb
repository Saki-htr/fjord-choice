# frozen_string_literal: true

class User < ApplicationRecord
  has_many :user_assigned_issues, dependent: :destroy
  has_many :assigned_issue, through: :user_assigned_issues

  has_many :user_pull_requests, dependent: :destroy
  has_many :review_requested_pull_requests, through: :user_pull_requests
end
