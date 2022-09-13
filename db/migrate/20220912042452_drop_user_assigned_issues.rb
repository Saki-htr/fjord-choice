class DropUserAssignedIssues < ActiveRecord::Migration[7.0]
  def change
    drop_table :user_assigned_issues do |t|
      t.references :user, null: false, foreign_key: true
      t.references :assigned_issues, null: false, foreign_key: true

      t.timestamps
    end

    create_table :user_assigned_issues do |t|
      t.references :user, null: false, foreign_key: true
      t.references :assigned_issue, null: false, foreign_key: true

      t.timestamps
    end
    add_index :user_assigned_issues, [:user_id, :assigned_issue_id], unique: true
  end
end
