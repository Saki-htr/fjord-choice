# frozen_string_literal: true

class HomeController < ApplicationController
  require 'uri'
  require 'net/http'
  require 'json'

  def index
    @users = User.all

    # ✅issue
    issues = (1..5).map do |page| # 500件取得
      JSON.parse(Net::HTTP.get(URI.parse("https://api.github.com/repos/fjordllc/bootcamp/issues?state=all&sort=updated&per_page=100&page=#{page}")),
                 symbolize_names: true)
    end
    issues.flatten! # 1番外側の配列を削除

    # assigneeがnilの要素を削除
    issues.delete_if do |issue|
      issue[:assignee].nil?
    end

    # ✅PR
    pulls_uri = URI.parse('https://api.github.com/repos/fjordllc/bootcamp/pulls?state=all&') # 100件
    raw_pulls = Net::HTTP.get(pulls_uri)
    pulls = JSON.parse(raw_pulls, symbolize_names: true)

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
  end
end
