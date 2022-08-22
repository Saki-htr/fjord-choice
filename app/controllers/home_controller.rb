# frozen_string_literal: true

class HomeController < ApplicationController
  require 'uri'
  require 'net/http'
  require 'json'
  require 'octokit'

  def index
    AssignedIssue.create
    AssignedIssue.update
    ReviewRequestedPullRequest.create
    ReviewRequestedPullRequest.update
  end
end
