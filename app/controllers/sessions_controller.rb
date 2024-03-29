# frozen_string_literal: true

class SessionsController < ApplicationController
  def create
    user = User.find_or_create_from_auth_hash!(request.env['omniauth.auth'])
    session[:user_id] = user.id
    redirect_to root_path, notice: 'メンバーに追加されました'
  end

  def failure
    redirect_to root_path, notice: 'ログインに失敗しました'
  end
end
