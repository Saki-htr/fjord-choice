# frozen_string_literal: true

class ApplicationController < ActionController::Base
  helper_method :logged_in?, :not_logged_in?, :current_user

  private

  def logged_in?
    !!current_user
  end

  def not_logged_in?
    !logged_in?
  end

  def current_user
    return unless session[:user_id]

    @current_user ||= User.find_by(id: session[:user_id])
    unless @current_user
      session[:user_id] = nil
    end
    @current_user
  end
end
