class CreateUserAssignedIssues < ActiveRecord::Migration[7.0]
  def change
    create_table :user_assigned_issues do |t|
      t.references :user, null: false, foreign_key: true
      t.references :assigned_issues, null: false, foreign_key: true

      t.timestamps
    end
  end
end
