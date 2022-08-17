# frozen_string_literal: true

class HomeController < ApplicationController
  require 'uri'
  require 'net/http'
  require 'json'
  require 'octokit'

  def index
    AssignedIssue.create
    ReviewRequestedPullRequest.create
  end
end
