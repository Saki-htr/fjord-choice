class DropRawIssues < ActiveRecord::Migration[7.0]
  def change
    drop_table :raw_issues do |t|
      t.jsonb :issue, null: false

      t.timestamps
    end

    drop_table :raw_pull_requests do |t|
      t.jsonb :pull_request, null: false

      t.timestamps
    end
  end
end
