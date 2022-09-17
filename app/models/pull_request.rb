# frozen_string_literal: true

class PullRequest < ApplicationRecord
  enum state: {
    open: 0,
    closed: 1
  }

  class << self
    def review_requested(user)
      ReviewRequestedPullRequest.where("#{user.uid} = ANY(reviewers)")
    end
    # def requested?(user)
    #   if ReviewRequestedPullRequest.review_requested(user).count >= 1
    #     ReviewRequestedPullRequest.review_requested(user)
    #   else
    #     false
    #   end
    # end
  end
end
