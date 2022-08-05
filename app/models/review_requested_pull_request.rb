# frozen_string_literal: true

class ReviewRequestedPullRequest < ApplicationRecord
  has_one :raw_pull_request, dependent: :nullify

  has_many :user_pull_requests, dependent: :destroy
  has_many :users, through: :user_pull_requests
end
