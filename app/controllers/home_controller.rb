# frozen_string_literal: true

class HomeController < ApplicationController
  require 'json'
  require 'octokit'

  def index
    reset_session
    @users = User.order('LOWER(name)')
  end

  def tos; end

  def pp; end
end
