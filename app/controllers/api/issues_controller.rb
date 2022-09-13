# frozen_string_literal: true

class Api::IssuesController < ApplicationController
  skip_before_action :verify_authenticity_token
  def create
    assigned_issue = AssignedIssue.find_or_initialize_by(number: params[:number])
    assigned_issue.update!(
      number: params[:number],
      point: params[:labels].map(&:to_i).sum,
      assignees: params[:assignees]
    )
    assigned_issue.save!

    redirect_to root_path
  end

  # def issue_params
  #   params.require(:issue).permit(:number, :labels, :assignees)
  # end
end
