# frozen_string_literal: true

class Api::PullsController < ApplicationController
  skip_before_action :verify_authenticity_token
  def create
    review_requested_pr = ReviewRequestedPullRequest.find_or_initialize_by(number: params[:number])
    review_requested_pr.update!(
      title: params[:title],
      number: params[:number],
      state: params[:state],
      reviewers: params[:reviewers].map(&:to_s)
    )
    review_requested_pr.save!

    redirect_to root_path
  end
end
