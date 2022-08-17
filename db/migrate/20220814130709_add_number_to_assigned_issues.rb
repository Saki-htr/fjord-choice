class AddNumberToAssignedIssues < ActiveRecord::Migration[7.0]
  def change
    add_column :assigned_issues, :number, :integer
    change_column_null :assigned_issues, :number, false
    add_index :assigned_issues, :number, unique: true
  end
end
