class RemoveRawIssueFromAssignedIssues < ActiveRecord::Migration[7.0]
  def change
    remove_foreign_key :assigned_issues, :raw_issues
    remove_index :assigned_issues, :raw_issue_id
    remove_reference :assigned_issues, :raw_issue

    remove_foreign_key :review_requested_pull_requests, :raw_pull_requests
    remove_index :review_requested_pull_requests, :raw_pull_request_id
    remove_reference :review_requested_pull_requests, :raw_pull_request
  end
end
