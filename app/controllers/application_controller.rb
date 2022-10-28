# frozen_string_literal: true

class ApplicationController < ActionController::Base
  helper_method :logged_in?, :not_logged_in?, :current_user

  private

  def logged_in?
    !!session[:user_id]
  end

  def not_logged_in?
    !!!session[:user_id]
  end

  def current_user
    return unless session[:user_id]

    @current_user ||= User.find(session[:user_id])
  end
end
