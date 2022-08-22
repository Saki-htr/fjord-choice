class AddStateToReviewRequestedPullRequests < ActiveRecord::Migration[7.0]
  def change
    add_column :review_requested_pull_requests, :state, :integer, null: false
  end
end
