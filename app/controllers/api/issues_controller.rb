# frozen_string_literal: true

class Api::IssuesController < ApplicationController
  skip_before_action :verify_authenticity_token
  def create
    assigned_issue = AssignedIssue.find_or_initialize_by(number: params[:number]) # 引数に渡した条件でレコードを探し、そのレコードがあればそれを返し、無ければ新しくインスタンス作成する(saveはしない)

    assigned_issue.update!(
      number: params[:number],
      point: params[:labels].map(&:to_i).sum,
      assignees: params[:assignees]
    )

    user = User.find_by(uid: params[:assignees])
    assigned_issue.users << user # 中間テーブルのレコード作成

    redirect_to root_path
  end
  # def issue_params
  #   params.require(:issue).permit(:number, :labels, :assignees)
  # end
end
