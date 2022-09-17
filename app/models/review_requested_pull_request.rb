# frozen_string_literal: true

class ReviewRequestedPullRequest < ApplicationRecord
  has_many :user_pull_requests, dependent: :destroy
  has_many :users, through: :user_pull_requests

  enum state: {
    open: 0,
    closed: 1
  }

  class << self
    def review_requested(user)
      ReviewRequestedPullRequest.where("#{user.uid} = ANY(reviewers)")
    end
  end
end
