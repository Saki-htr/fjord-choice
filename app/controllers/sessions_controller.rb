# frozen_string_literal: true

class SessionsController < ApplicationController
  # ログイン機能
  def create
    # find~は、Railsのメソッドではなく、自分で定義するメソッド
    # request.env["omniauth.github"]には、GitHubから渡されたユーザー情報や、OAuthのアクセストークンが格納されてる
    user = User.find_or_create_from_auth_hash!(request.env['omniauth.auth'])
    # find~メソッドが返すuserオブジェクトのidを、セッションに格納する = 「ログイン」
    session[:user_id] = user.id # 必ずsession[:user_id]にする
    redirect_to root_path, notice: 'メンバーに追加されました'
  end
end
