# frozen_string_literal: true

class HomeController < ApplicationController
  def index
    @users = User.students.order('LOWER(name)')
    @current_user = current_user
  end

  def tos; end

  def pp; end

  def about; end
end
