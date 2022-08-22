# frozen_string_literal: true

namespace :issues do
  desc 'create issue information'
  task create: :environment do
    AssignedIssue.create
  end

  desc 'update issue information'
  task update: :environment do
    AssignedIssue.update
  end
end

namespace :pull_requests do
  desc 'create pull_request information'
  task create: :environment do
    ReviewRequestedPullRequest.create
  end

  desc 'update pull_request information'
  task update: :environment do
    ReviewRequestedPullRequest.update
  end
end
