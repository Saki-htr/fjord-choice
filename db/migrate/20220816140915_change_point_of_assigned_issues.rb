class ChangePointOfAssignedIssues < ActiveRecord::Migration[7.0]
  def up
    change_column :assigned_issues, :point, :integer, default: 0
    change_column :assigned_issues, :assignees, :integer, array: true, default: []
  end

  def down
    change_column :assigned_issues, :point, :integer
    change_column :assigned_issues, :assignees, :integer, array: true
  end
end
