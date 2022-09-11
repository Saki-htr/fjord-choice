class RemoveReviewersFromReviewRequestedPullRequests < ActiveRecord::Migration[7.0]
  def change
    remove_index :review_requested_pull_requests, :reviewers
    remove_column :review_requested_pull_requests, :reviewers, :string
    add_column :review_requested_pull_requests, :reviewers, :integer, default: [], null: false, array: true
    add_index :review_requested_pull_requests, :reviewers
  end
end
