# frozen_string_literal: true

namespace :saki_issues do
  desc 'Saki-htrのissueのデータを、APIリクエストしてDB保存する'
  task request_saki_issues: :environment do
    client = Octokit::Client.new(client_id: ENV['GITHUB_KEY'], client_secret: ENV['GITHUB_SECRET'])

    student = %w[Saki-htr]

    # issueもPRも両方入っている
    assigned_issues = student.flat_map do |_s|
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

      pp client.last_response.headers
    end
  end
end
