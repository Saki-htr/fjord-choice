# frozen_string_literal: true

class ReviewRequestedPullRequest < ApplicationRecord
  belongs_to :raw_pull_request
end
