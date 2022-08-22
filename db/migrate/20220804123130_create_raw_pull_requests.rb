class CreateRawPullRequests < ActiveRecord::Migration[7.0]
  def change
    create_table :raw_pull_requests do |t|
      t.jsonb :pull_request, null: false

      t.timestamps
    end
  end
end
