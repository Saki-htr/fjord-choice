# frozen_string_literal: true

class HomeController < ApplicationController
  require 'uri'
  require 'net/http'
  require 'json'
  require 'octokit'

  def index
    client = Octokit::Client.new \
      client_id: ENV['GITHUB_KEY'],
      client_secret: ENV['GITHUB_SECRET']

    # ✅ issue
    issues = (1..1).map do |page|
      client.search_issues('repo:fjordllc/bootcamp is:issue', options = { state: 'all', sort: 'updated', per_page: 3, page: page })
    end
    issues.flatten! # 1番外側の配列を削除

    # AssignedIssueにレコードをCreateする
    issues.each do |issue|
      issue[:items].each do |i|
        # 既に保存してるissueの番号と同じ場合、繰り返し処理を抜ける
        next if AssignedIssue.exists?(number: i[:number])

        assigned_issue = AssignedIssue.new

        # numberカラムの保存
        assigned_issue.number = i[:number]

        # pointカラムの保存
        i[:labels].each do |label|
          next if label[:name].to_i == 0 #ここで繰り返しを抜ける
          #nextの条件がfalseの時だけ以下を実行
          assigned_issue.point = label[:name].to_i
        end

        # assigneesの保存
        if i[:assignees].empty?
          assigned_issue.assignees = []
        else
          i[:assignees].each do |assignee|
            assigned_issue.assignees = []
            assigned_issue.assignees << assignee[:id]
            assigned_issue.assignees
          end
        end

        assigned_issue.save!
      end
    end

    # ✅ PR
    # pulls = client.pull_requests('fjordllc/bootcamp', options = { state: 'open', per_page: 100 }) # openなPRしか取得しないので最大100件で充分
    # pulls.flatten!

    # pull[:requested_reviewers][0][:login]がnilの要素を削除
    # pulls.delete_if do |pull|
    #   pull[:requested_reviewers].empty?
    # end

    # results = []
    # @users.each do |user|
    #   issues_of_registered_users = issues.select do |issue|
    #     issue[:assignee][:login] == user.name
    #   end

      # userがreviewerとして登録されているPRを、userごとに抽出する
      # 変数に入れることで、破壊的変更メソッドでなくてもselect後の状態を使える
    #   pulls_of_registered_users = pulls.select do |pull|
    #     pull[:requested_reviewers][0][:login] == user.name
    #   end
    #   pulls_of_registered_users = pulls_of_registered_users.to_json # もしかしたら .to_json しなくてもよしなにjson型にしてくれるかも?
    #   results << { user: user, assigned_issues: issues_of_registered_users, review_requested_pull_requests: pulls_of_registered_users }
    # end

    # raw_issueテーブルに保存
    # AssignedIssue.destroy_all
    # RawIssue.destroy_all #AssignedIssueと紐づいてるのでdeleteでもdestroyでも削除できない

    # results.each do |result|
    #   result[:assigned_issues].each do |i|
    #     raw_issue = RawIssue.new
    #     raw_issue.issue = i.to_hash.to_json
    #     raw_issue.save!

    #     i[:labels].each do |n|
    #       next if n[:name].to_i == 0 #ここで繰り返しを抜ける
    #       AssignedIssue.create!( #nextの条件がfalseの時だけ実行
    #         point: n[:name].to_i,
    #         raw_issue_id: raw_issue.id
    #       )
    #     end
    #   end
    # end
  end
end

