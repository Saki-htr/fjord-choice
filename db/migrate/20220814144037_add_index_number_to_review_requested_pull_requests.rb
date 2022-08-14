class AddIndexNumberToReviewRequestedPullRequests < ActiveRecord::Migration[7.0]
  def change
    add_index :review_requested_pull_requests, :number, unique: true
  end
end
