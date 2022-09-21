# frozen_string_literal: true

class PullRequest < ApplicationRecord
  validates :number, presence: true, uniqueness: true
  with_options presence: true do
    validates :title
    validates :state
    validates :reviewers
  end
  enum state: {
    open: 0,
    closed: 1
  }


  def self.review_requested(user)
    PullRequest.where("#{user.uid} = ANY(reviewers)").where(state: 'open')
  end

end
