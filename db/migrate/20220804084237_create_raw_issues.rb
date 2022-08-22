class CreateRawIssues < ActiveRecord::Migration[7.0]
  def change
    create_table :raw_issues do |t|
      t.jsonb :raw_issue, null: false

      t.timestamps
    end
  end
end
