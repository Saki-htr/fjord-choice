class ChangeIssueColomnDefault < ActiveRecord::Migration[7.0]
  def change
    change_column_default :issues, :point, nil
    change_column_default :issues, :assignees, nil
    change_column_default :pull_requests, :reviewers, nil
  end
end
