class DropUserPullRequests < ActiveRecord::Migration[7.0]
  def change
    drop_table :user_pull_requests do |t|
      t.references :review_requested_pull_request, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps null: false
    end
  end
end
