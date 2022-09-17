# frozen_string_literal: true

class PullRequest < ApplicationRecord
  enum state: {
    open: 0,
    closed: 1
  }

  class << self
    def review_requested(user)
      PullRequest.where("#{user.uid} = ANY(reviewers)")
    end
  end
end
