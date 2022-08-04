class CreateReviewRequestedPullRequests < ActiveRecord::Migration[7.0]
  def change
    create_table :review_requested_pull_requests do |t|
      t.references :raw_pull_request, null: false, foreign_key: true
      t.string :title, null: false
      t.integer :number, null: false

      t.timestamps
    end
  end
end
