# Rails.rootを使用するために必要
require File.expand_path(File.dirname(__FILE__) + "/environment")
# cronを実行する環境変数
rails_env = ENV['RAILS_ENV'] || :development
# 通常だと、production環境でしか処理が走らない
# cronを実行する環境変数をセットし、dev環境のみで処理が走るようにする
set :environment, rails_env
# cronのログの吐き出し場所
set :output, "#{Rails.root}/log/cron.log"

every 1.minute do
  rake 'issues:create'
  rake 'issues:update'
  rake 'pull_requests:create'
  rake 'pull_requests:update'
end


