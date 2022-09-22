# frozen_string_literal: true

class Api::IssuesController < ApplicationController
  protect_from_forgery except: :create
  before_action :require_token, only: [:create]
  def create
    issue = Issue.find_or_create_by(number: params[:number])

    if issue.update!(point: params[:labels].map(&:to_i).sum, assignees: params[:assignees])
      head :created
    else
      head :unprocessable_entity
    end
  end

  def require_token
    return if ENV['FJORD_CHOICE_TOKEN'] == params[:token]

    head :unauthorized
  end

  # def issue_params
  #   params.require(:issue).permit(:number, :labels, :assignees)
  # end
end
