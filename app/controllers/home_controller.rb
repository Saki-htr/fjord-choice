# frozen_string_literal: true

class HomeController < ApplicationController
  require 'json'
  require 'octokit'

  def index
    @users = User.order('LOWER(name)')
  end
end
