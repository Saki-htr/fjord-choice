# frozen_string_literal: true

class Api::PullsController < ApplicationController
  protect_from_forgery except: :create
  before_action :require_token, only: [:create]

  def create
    review_requested_pr = PullRequest.find_or_initialize_by(number: params[:number])
    review_requested_pr.update!(pull_params)
    redirect_to root_path
  end

  protected

  def require_token
    return if ENV['FJORD_CHOICE_TOKEN'] == params[:token]

    head :unauthorized
  end

  private

  def pull_params
    params.require(:pull).permit(:title, :number, :state, reviewers: [])
  end
end
