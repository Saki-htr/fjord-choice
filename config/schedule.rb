# Rails.rootを使用するために必要
require File.expand_path(File.dirname(__FILE__) + "/environment")
# cronを実行する環境変数
rails_env = ENV['RAILS_ENV'] || :development
# 通常だと、production環境でしか処理が走らない
# cronを実行する環境変数をセットし、dev環境のみで処理が走るようにする
set :environment, :development
# cronのログの吐き出し場所
set :output, "#{Rails.root}/log/cron.log"

every 1.minute do
  runner "AssignedIssue.create"
  runner "AssignedIssue.update"
end
every 1.minute do
  runner "ReviewRequestedPullRequest.create"
  runner "ReviewRequestedPullRequest.update"
end

