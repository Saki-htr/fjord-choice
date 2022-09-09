# frozen_string_literal: true

class Api::PullsController < ApplicationController
  skip_before_action :verify_authenticity_token
  def create
    Rails.logger.debug 'params'
    Rails.logger.debug params # paramsの中身デバッグ
    Rails.logger.debug 'params[:reviewers].class'
    Rails.logger.debug params[:reviewers].class # paramsの中身デバッグ

    # レコード作成or更新
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
