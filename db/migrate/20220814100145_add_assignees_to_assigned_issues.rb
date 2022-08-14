class AddAssigneesToAssignedIssues < ActiveRecord::Migration[7.0]
  def change
    add_column :assigned_issues, :assignees, :integer, array: true
    change_column_null :assigned_issues, :assignees, false
    add_index :assigned_issues, :assignees

    add_column :review_requested_pull_requests, :reviewers, :integer, array: true
    change_column_null :review_requested_pull_requests, :reviewers, false
    add_index :review_requested_pull_requests, :reviewers
  end
end
