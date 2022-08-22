# frozen_string_literal: true

class ReviewRequestedPullRequest < ApplicationRecord
  require 'octokit'
  has_many :user_pull_requests, dependent: :destroy
  has_many :users, through: :user_pull_requests

  enum state: {
    open: 0,
    closed: 1,
  }

  class << self
    def client
      Octokit::Client.new(client_id: ENV['GITHUB_KEY'],
                          client_secret: ENV['GITHUB_SECRET'])
    end

    def api_request_for_create
      client.pull_requests('fjordllc/bootcamp', { state: 'open', per_page: 100 })
    end

    def delete_release_branch
      api_request_for_create.delete_if do |pull|
        pull[:labels][0][:name] == 'release' unless pull[:labels].empty?
      end
    end

    def create
      delete_release_branch.each do |pull|
        next if ReviewRequestedPullRequest.exists?(number: pull[:number])

        pull_request = ReviewRequestedPullRequest.new
        pull_request.number = pull[:number]
        pull_request.state = pull[:state]
        pull_request.title = pull[:title]
        pull_request.reviewers = pull[:requested_reviewers].map(&:id)
        pull_request.save!
      end
    end

    def api_request_for_update
      ReviewRequestedPullRequest.pluck(:number).map do |number|
        client.pull_request('fjordllc/bootcamp', number)
      end
    end

    def update
      api_request_for_update.each do |pull|
        pull_request = ReviewRequestedPullRequest.find_by(number: pull[:number])
        pull_request.state = pull[:state]
        pull_request.title = pull[:title]
        pull_request.reviewers = pull[:requested_reviewers].map(&:id)
        pull_request.save!
      end
    end
  end
end
