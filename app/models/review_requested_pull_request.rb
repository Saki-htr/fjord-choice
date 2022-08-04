# frozen_string_literal: true

class ReviewRequestedPullRequest < ApplicationRecord
  belongs_to :raw_pull_request

  has_many :user_review_requested_pull_requests, dependent: :destroy
  has_many :users, through: :user_review_requested_pull_requests
end
