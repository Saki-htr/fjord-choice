# frozen_string_literal: true

class API::PullsController < APIController
  before_action :authenticate, only: [:create]

  def create
    pull_request = PullRequest.upsert(pull_params, unique_by: :number)
    head :created
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
