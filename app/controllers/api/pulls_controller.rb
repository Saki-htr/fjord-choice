# frozen_string_literal: true

class Api::PullsController < ApplicationController
  protect_from_forgery except: :create
  before_action :authenticate, only: [:create]

  def create
    pull_request = PullRequest.find_or_create_by(number: pull_params[:number])
    if pull_request.update!(pull_params)
      head :created
    else
      head :unprocessable_entity #=> 422
    end
  end

  private

  def fjord_choice_token
    ENV['FJORD_CHOICE_TOKEN']
  end

  def authenticate
    authenticate_or_request_with_http_token do |token, _options|
      ActiveSupport::SecurityUtils.secure_compare(token, fjord_choice_token)
    end
  end

  def pull_params
    params.require(:pull).permit(:title, :number, :state, reviewer_uids: [])
  end
end
