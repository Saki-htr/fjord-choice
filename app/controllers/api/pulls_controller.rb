# frozen_string_literal: true

class Api::PullsController < ApplicationController
  protect_from_forgery except: :create
  before_action :authenticate, only: [:create]

  def create
    pull_request = PullRequest.find_or_create_by(number_params)

    if pull_request.update!(pull_params)
      byebug
      head :created
    else
      head :unprocessable_entity
    end
  end

  private

  def authenticate
    authenticate_or_request_with_http_token do |token, _options|
      token == ENV['FJORD_CHOICE_TOKEN']
    end
  end

  def pull_params
    params.require(:pull).permit(:title, :number, :state, reviewers: [])
  end

  def number_params
    params.require(:pull).permit(:number)
  end

end
