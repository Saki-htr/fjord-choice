# frozen_string_literal: true

class Api::IssuesController < ApplicationController
  protect_from_forgery except: :create
  before_action :require_token, only: [:create]
  def create
    assigned_issue = Issue.find_or_initialize_by(number: params[:number]) # 引数に渡した条件でレコードを探し、そのレコードがあればそれを返し、無ければ新しくインスタンス作成する(saveはしない)

    assigned_issue.update!(
      number: params[:number],
      point: params[:labels].map(&:to_i).sum,
      assignees: params[:assignees]
    )

    if assigned_issue.save
      render json: { status: :created }
    else
      render json: assigned_issue.errors, status: :unprocessable_entity
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
