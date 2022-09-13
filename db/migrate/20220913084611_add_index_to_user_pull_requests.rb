class AddIndexToUserPullRequests < ActiveRecord::Migration[7.0]
  def change
    add_index :user_pull_requests, [:user_id, :review_requested_pull_request_id], unique: true, name: 'index_user_pull_requests_on_user_id_and_pull_request_id'
  end
end
