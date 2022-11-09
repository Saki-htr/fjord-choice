# frozen_string_literal: true

module ApplicationHelper
  def url_for_pulls(user)
    "https://github.com/fjordllc/bootcamp/pulls?q=is%3Apr+assignee%3A#{user.name}+-label%3Arelease+"
  end

  def url_for_pull(pull)
    "https://github.com/fjordllc/bootcamp/pull/#{pull.number}"
  end
end
