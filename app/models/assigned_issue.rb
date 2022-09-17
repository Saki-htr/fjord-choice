# frozen_string_literal: true

class AssignedIssue < ApplicationRecord
  has_many :user_assigned_issues, dependent: :destroy
  has_many :users, through: :user_assigned_issues

  # class << self
  #   def client
  #     Octokit::Client.new(client_id: ENV['GITHUB_KEY'],
  #                         client_secret: ENV['GITHUB_SECRET'])
  #   end

  #   def api_request_for_create
  #     request = []
  #     request << client.search_issues('repo:fjordllc/bootcamp is:issue', { state: 'all', sort: 'updated', per_page: 100 })
  #   end

  #   def create
  #     api_request_for_create.each do |issue|
  #       issue[:items].each do |i|
  #         next if AssignedIssue.exists?(number: i[:number])

  #         assigned_issue = AssignedIssue.new
  #         assigned_issue.number = i[:number]
  #         i[:labels].each do |label|
  #           next if label[:name].to_i.zero?

  #           assigned_issue.point = label[:name].to_i
  #         end
  #         assigned_issue.assignees = i[:assignees].map(&:id)
  #         assigned_issue.save!
  #       end
  #     end
  #   end
  #     #   def api_request_for_update
  #     AssignedIssue.pluck(:number).map do |number|
  #       client.issue('fjordllc/bootcamp', number)
  #     end
  #   end

  #   def update
  #     api_request_for_update.each do |issue|
  #       assigned_issue = AssignedIssue.find_by(number: issue[:number])

  #       issue[:labels].each do |label|
  #         next if label[:name].to_i.zero?

  #         assigned_issue.point = label[:name].to_i
  #       end
  #       assigned_issue.assignees = issue[:assignees].map(&:id)
  #       assigned_issue.save!
  #     end
  #   end
  # end
end
