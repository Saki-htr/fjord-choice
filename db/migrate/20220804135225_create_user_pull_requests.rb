class CreateUserPullRequests < ActiveRecord::Migration[7.0]
  def change
    create_table :user_pull_requests do |t|
      t.references :user, null: false, foreign_key: true
      t.references :review_requested_pull_request, null: false, foreign_key: true

      t.timestamps
    end
  end
end
