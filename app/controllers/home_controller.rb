# frozen_string_literal: true

class HomeController < ApplicationController
  def index
    @users = User.student.order('LOWER(name)')
  end

  def tos; end

  def pp; end

  def about; end
end
