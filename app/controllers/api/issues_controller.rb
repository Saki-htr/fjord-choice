class Api::IssuesController < ApplicationController
  skip_before_action :verify_authenticity_token
  def create
  # 読み込み時に一度パースが必要
  # json_request = JSON.parse(request.body.read)

  # パース後のデータを表示
  # p "json_request"
  # p json_request
  p "params"
  p params

  assigned_issue = AssignedIssue. find_or_initialize_by(number: params[:number])
  assigned_issue.update!(
    number: params[:number],
    point: params[:labels].map(&:to_i).sum,
    assignees: params[:assignees].map(&:to_s)
  )
  assigned_issue.save!

  private

  def issue_params
    params.require(:issue).permit(:number, :labels, :assignees)
  end
end
