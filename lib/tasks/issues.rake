# frozen_string_literal: true

namespace :issues do
  desc 'チーム開発に取り組んでいる最中の受講生のissueのデータを、APIリクエストしてDB保存する'
  task request_api_issues: :environment do
    client = Octokit::Client.new(client_id: ENV['GITHUB_KEY'], client_secret: ENV['GITHUB_SECRET'])

    students = %w[daiki0381 keiz1213 shirotamaki fuwa-syugyo pachikuriii hikarook94 yamatatsu10969 sadanora Nabegon siso25
                  AyakaTakashima akingo55 shucream-p OdenTakashi ksmxxxxxx]

    # issueもPRも両方入っている
    assigned_issues = students.flat_map do |student|
      client.list_issues('fjordllc/bootcamp', { state: 'all', assignee: student })
    end

    # PRの要素を取り除く(これでreleaseブランチも排除できる)
    assigned_issues.delete_if do |issue|
      issue[:html_url].include?('pull')
    end

    assigned_issues.each do |issue|
      next if Issue.exists?(number: issue[:number])

      new_issue = Issue.new
      new_issue.number = issue[:number]

      new_issue.point = 0 if issue[:labels].empty? # ラベルが1枚も貼られてない=空配列の場合

      issue[:labels].each do |label|
        new_issue.point = label[:name].to_i
      end

      new_issue.assignee_uids = []
      new_issue.assignee_uids << issue[:assignees][0][:id] # assigneeに入ってる人が1人だけという想定
      new_issue.save!
    end
  end
end
