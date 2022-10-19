class RenameAssigneesColumnToIssues < ActiveRecord::Migration[7.0]
  def change
    rename_column :issues, :assignees, :assignee_uids
    rename_column :pull_requests, :reviewers, :reviewer_uids
  end
end
