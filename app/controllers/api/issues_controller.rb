# frozen_string_literal: true

class Api::IssuesController < ApplicationController
  skip_before_action :verify_authenticity_token
  def create
    assigned_issue = AssignedIssue.find_or_initialize_by(number: params[:number]) # 引数に渡した条件でレコードを探し、そのレコードがあればそれを返し、無ければ新しくインスタンス作成する(saveはしない)

    assigned_issue.update!(
      number: params[:number],
      point: params[:labels].map(&:to_i).sum,
      assignees: params[:assignees].map(&:to_i)
    )

    user = User.find_by(uid: params[:assignees])
    assigned_issue.users << user

    # assigned_issue.number = params[:number]
    # assigned_issue.point = params[:labels].map(&:to_i).sum
    # assigned_issue.assignees = params[:assignees].map(&:to_s)

    # 中間テーブルのレコード作成
    # user =  User.find_by(uid: params[:assignees])
    # pp user.id
    # pp assigned_issue.id
    # UserAssignedIssue.create!(
    #   # byebug
    #   user_id: user.id,
    #   assigned_issues_id: assigned_issue.id
    # )

    redirect_to root_path
  end
  # def issue_params
  #   params.require(:issue).permit(:number, :labels, :assignees)
  # end
end
