# frozen_string_literal: true

class Api::PullsController < ApplicationController
  protect_from_forgery except: :create
  def create
    review_requested_pr = ReviewRequestedPullRequest.find_or_initialize_by(number: params[:number])
    review_requested_pr.update!(pull_params)
    redirect_to root_path
  end

  private
  def pull_params
    params.require(:pull).permit(:title, :number, :state, :reviewers)
  end
end
