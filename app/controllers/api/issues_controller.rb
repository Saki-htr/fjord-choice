# frozen_string_literal: true

class Api::IssuesController < ApplicationController
  protect_from_forgery except: :create
  before_action :authenticate, only: [:create]

  def create
    # assigneesが[]の時の処理が未対応
    issue = Issue.find_or_create_by(number: issue_params[:number])
    if issue.update!(point: point, assignees: issue_params[:assignees])
      head :created #=> 201
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

  def issue_params
    params.require(:issue).permit(:number, point: [], assignees: [])
  end

  def point
    issue_params[:point].map(&:to_i).sum
  end
end
