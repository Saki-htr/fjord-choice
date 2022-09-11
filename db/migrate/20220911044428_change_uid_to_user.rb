class ChangeUidToUser < ActiveRecord::Migration[7.0]
  def change
    remove_index :users, column: [:provider, :uid]
    remove_column :users, :uid, :string
    add_column :users, :uid, :integer, null: false
    add_index :users, [:provider, :uid], unique: true
  end
end
