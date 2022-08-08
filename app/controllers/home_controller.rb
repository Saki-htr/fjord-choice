# frozen_string_literal: true

class HomeController < ApplicationController
  require 'uri'
  require 'net/http'
  require 'json'
  require 'octokit'

  def index
    @users = User.all

    client = Octokit::Client.new \
    :client_id     => ENV['GITHUB_KEY'],
    :client_secret => ENV['GITHUB_SECRET']

    # ✅ issue
    issues = (1..3).map do |page|
      client.list_issues("fjordllc/bootcamp", options = {:state =>'all', :sort =>'updated', :per_page =>100, :page =>page})
    end
    issues.flatten! # 1番外側の配列を削除

    # assigneeがnilの要素を削除
    issues.delete_if do |issue|
      issue[:assignee].nil?
    end

    # レスポンスに混ざっているPRの要素を削除
    issues.delete_if do |issue|
      issue.has_key?(:pull_request)
    end

    # ✅ PR
    pulls = client.pull_requests("fjordllc/bootcamp", options = {:state =>'open', :per_page =>100}) #openなPRしか取得しないので最大100件で充分
    pulls.flatten!

    # pull[:requested_reviewers][0][:login]がnilの要素を削除
    pulls.delete_if do |pull|
      pull[:requested_reviewers].empty?
    end

    results = []
    @users.each do |user|
      issues_of_registered_users = issues.select do |issue|
        issue[:assignee][:login] == user.name
      end

      # userがreviewerとして登録されているPRを、userごとに抽出する
      # 変数に入れることで、破壊的変更メソッドでなくてもselect後の状態を使える
      pulls_of_registered_users = pulls.select do |pull|
        pull[:requested_reviewers][0][:login] == user.name
      end
      pulls_of_registered_users = pulls_of_registered_users.to_json # もしかしたら .to_json しなくてもよしなにjson型にしてくれるかも?
      results << { user: user, assigned_issues: issues_of_registered_users, review_requested_pull_requests: pulls_of_registered_users }
    end

    # raw_issueテーブルに保存
    results.each do |result|
      result[:assigned_issues].each do|i|
        raw_issue = RawIssue.new
        raw_issue.issue = i.to_hash.to_json
        raw_issue.save!
      end
    end
  end
end
