# frozen_string_literal: true

class ReviewRequestedPullRequest < ApplicationRecord
  require 'octokit'
  has_many :user_pull_requests, dependent: :destroy
  has_many :users, through: :user_pull_requests

  class << self
    def client
      Octokit::Client.new(client_id: ENV['GITHUB_KEY'],
                          client_secret: ENV['GITHUB_SECRET'])
    end

    def api_request
      client.pull_requests('fjordllc/bootcamp', { state: 'open', per_page: 100 })
    end

    def delete_release_branch
      api_request.delete_if do |pull|
        pull[:labels][0][:name] == 'release' unless pull[:labels].empty? # nil避け
      end
    end

    # rubocop:disable Metrics/MethodLength
    def create
      delete_release_branch.each do |pull|
        next if ReviewRequestedPullRequest.exists?(number: pull[:number])

        pull_request = ReviewRequestedPullRequest.new
        pull_request.number = pull[:number]
        pull_request.title = pull[:title]
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
    # rubocop:enable Metrics/MethodLength
  end
end
