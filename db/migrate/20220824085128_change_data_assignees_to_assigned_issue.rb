class ChangeDataAssigneesToAssignedIssue < ActiveRecord::Migration[7.0]
  def change
    change_column :assigned_issues, :assignees, :string, array: true
    change_column :review_requested_pull_requests, :reviewers, :string, array: true
  end
end
