class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :name, null: false
      t.integer :github_id, null: false
      t.string :provider, null: false
      t.string :uid, null: false

      t.timestamps
      t.index [:provider, :uid], unique: true
    end
  end
end
