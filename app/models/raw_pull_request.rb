# frozen_string_literal: true

class RawPullRequest < ApplicationRecord
  belongs_to: review_requested_pull_request
end
