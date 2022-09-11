# frozen_string_literal: true

class HomeController < ApplicationController
  require 'json'
  require 'octokit'

  def index
    @users = User.all
  end
end
