class RenameRawIssueColumnToRawIssues < ActiveRecord::Migration[7.0]
  def change
    rename_column :raw_issues, :raw_issue, :issue
  end
end
