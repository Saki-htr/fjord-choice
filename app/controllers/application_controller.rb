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
  # 退会したuserが別端末でアクセスした際にsessionが残っている場合、sessionを削除し、current_userの戻り値をnilにする
  rescue AcitveRecord::RecordNotFound
    reset_session

    nil
  end
end
