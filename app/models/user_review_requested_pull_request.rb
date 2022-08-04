# frozen_string_literal: true

class UserReviewRequestedPullRequest < ApplicationRecord
  belongs_to :user
  belongs_to :review_requested_pull_request
end
