# frozen_string_literal: true

class RawPullRequest < ApplicationRecord
  has_one :review_requested_pull_request
end
