class RemoveGithubIdFromUsers < ActiveRecord::Migration[7.0]
  def change
    remove_column :users, :github_id, :integer
  end
end
