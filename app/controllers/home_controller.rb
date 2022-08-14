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

        # number
        assigned_issue.number = i[:number]

        # point
        i[:labels].each do |label|
          next if label[:name].to_i == 0 #ここで繰り返しを抜ける
          #nextの条件がfalseの時だけ以下を実行
          assigned_issue.point = label[:name].to_i
        end

        # assignees
        if i[:assignees].empty?
          assigned_issue.assignees = []
        else
          i[:assignees].each do |assignee|
            assigned_issue.assignees = []
            assigned_issue.assignees << assignee[:id]
          end
        end

        assigned_issue.save!
      end
    end

    # ✅ PR
    pulls = client.pull_requests('fjordllc/bootcamp', options = { state: 'open', per_page: 20 }) # openなPRしか取得しないので最大100件で充分
    pulls.flatten!

    # releaseブランチ削除
    pulls.delete_if do |pull|
      unless pull[:labels].empty? #nil避け
        pull[:labels][0][:name] == "release"
      end
    end

    # PRテーブルにレコードをCreateする
    ReviewRequestedPullRequest.delete_all
    pulls.each do |pull|
      # 既に保存してるissueの番号と同じ場合、繰り返し処理を抜ける

      pull_request = ReviewRequestedPullRequest.new
      # number
      pull_request.number = pull[:number]
      # title
      pull_request.title = pull[:title]

      # reviewers
      if pull[:requested_reviewers].empty?
        pull_request.reviewers = []
      else
        pull[:requested_reviewers].each do |reviewer|
          pull_request.reviewers = []
          pull_request.reviewers << reviewer[:id]
        end
      end
      pull_request.save!
    end
  end
end

