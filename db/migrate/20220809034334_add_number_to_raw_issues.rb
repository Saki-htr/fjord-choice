class AddNumberToRawIssues < ActiveRecord::Migration[7.0]
  def change
    add_column :raw_issues, :number, :integer
    change_column_null :raw_issues, :number, false
    add_index :raw_issues, :number, unique: true
  end
end
