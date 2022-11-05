namespace :pulls do
  desc "ステートがopenなプルリクエストのデータを、APIリクエストしてDB保存する"
  task api_pulls: :environment do
    client = Octokit::Client.new(client_id: ENV['GITHUB_KEY'], client_secret: ENV['GITHUB_SECRET'])

    open_pulls = client.pull_requests('fjordllc/bootcamp', { state: 'open', per_page: 100 })

    # releaseブランチ削除
    open_pulls.delete_if do |pull|
      pull[:labels][0][:name] == 'release' unless pull[:labels].empty? # nil避け
    end

    open_pulls.each do |pull|
      new_pull = PullRequest.new
      new_pull.number = pull[:number]
      new_pull.title = pull[:title]
      new_pull.state = pull[:state]

      if pull[:requested_reviewers].empty?
        new_pull.reviewer_uids = []
      else
        pull[:requested_reviewers].each do |reviewer|
          new_pull.reviewer_uids = []
          new_pull.reviewer_uids << reviewer[:id]
        end
      end
      new_pull.save!
    end
  end
end
