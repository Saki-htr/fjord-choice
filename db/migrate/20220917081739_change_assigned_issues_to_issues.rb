class ChangeAssignedIssuesToIssues < ActiveRecord::Migration[7.0]
  def change
    rename_table :assigned_issues, :issues
  end
end
