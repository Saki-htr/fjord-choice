class DropUserAssinedIssues < ActiveRecord::Migration[7.0]
  def change
    drop_table :user_assigned_issues do |t|
      t.references :assigned_issue, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps null: false
    end
  end
end
