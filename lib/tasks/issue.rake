namespace :issue do
  desc "Saki-htrのissueのデータをAPIリクエストしてDB保存する"
  task api_request: :environment do
    client = Octokit::Client.new(client_id: ENV['GITHUB_KEY'], client_secret: ENV['GITHUB_SECRET'])

    students = ['hikarook94','fuwa-syugyo'] #ここにwikiにのってる人と休会中の人を入れる

    # issueもPRも両方入っている
    assigned_issues = students.flat_map  do |student|
      client.list_issues('fjordllc/bootcamp', { state: 'all', assignee: student})
    end

    # PRの要素を取り除く(これでreleaseブランチも排除できる)
    assigned_issues.delete_if do |issue|
      issue[:html_url].include?("pull")
    end

    assigned_issues.each do |issue|
      new_issue = Issue.new
      new_issue.number = issue[:number]

      issue[:labels].each do |label|
        next if label[:name].to_i.zero?
        label[:name]
        new_issue.point = label[:name].to_i
      end

      new_issue.assignee_uids = []
      new_issue.assignee_uids << issue[:assignees][0][:id] #assigneeに入ってる人が1人だけという想定
      new_issue.save!
    end
  end
end
