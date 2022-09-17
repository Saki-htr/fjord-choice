class ChangeReviewRequestedPullRequestsToPullRequests < ActiveRecord::Migration[7.0]
  def change
    rename_table :review_requested_pull_requests, :pull_requests
  end
end
