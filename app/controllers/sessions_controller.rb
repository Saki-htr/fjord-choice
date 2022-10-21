# frozen_string_literal: true

class SessionsController < ApplicationController
  def create
    user = User.find_or_create_from_auth_hash!(request.env['omniauth.auth'])
    if user
      session[:user_id] = user.id
      flash[:notice] = 'ログインしました'
    else
      flash[:notice] = '失敗しました'
    end
    redirect_to root_path, notice: 'メンバーに追加されました'
  end

  def failure
    redirect_to root_path, notice: 'キャンセルしました'
  end
end
