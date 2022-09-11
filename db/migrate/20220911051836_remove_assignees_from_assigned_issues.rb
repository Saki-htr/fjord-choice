class RemoveAssigneesFromAssignedIssues < ActiveRecord::Migration[7.0]
  def change
    remove_index :assigned_issues, :assignees
    remove_column :assigned_issues, :assignees, :string
    add_column :assigned_issues, :assignees, :integer, default: [], null: false, array: true
    add_index :assigned_issues, :assignees
  end
end
