# frozen_string_literal: true

class HomeController < ApplicationController
  require 'uri'
  require 'net/http'
  require 'json'
  require 'octokit'

  def index
    # ✅ PR
    pulls = client.pull_requests('fjordllc/bootcamp', options = { state: 'open', per_page: 20 }) # openなPRしか取得しないので最大100件で充分
    pulls.flatten!

    # releaseブランチ削除
    pulls.delete_if do |pull|
      pull[:labels][0][:name] == 'release' unless pull[:labels].empty? # nil避け
    end

    # PRテーブルにレコードをCreateする
    pulls.each do |pull|
      # 既に保存してるissueの番号と同じ場合、繰り返し処理を抜ける
      next if ReviewRequestedPullRequest.exists?(number: pull[:number])

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

  def api_request
    client = Octokit::Client.new \
      client_id: ENV['GITHUB_KEY'],
      client_secret: ENV['GITHUB_SECRET']

    # ✅ issue
    issues = (1..2).map do |page|
      client.search_issues('repo:fjordllc/bootcamp is:issue', options = { state: 'all', sort: 'updated', per_page: 3, page: page })
    end
    issues.flatten! # 1番外側の配列を削除
  end
end
