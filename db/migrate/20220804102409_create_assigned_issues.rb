class CreateAssignedIssues < ActiveRecord::Migration[7.0]
  def change
    create_table :assigned_issues do |t|
      t.references :raw_issue, null: false, foreign_key: true
      t.integer :point, null: false

      t.timestamps
    end
  end
end
