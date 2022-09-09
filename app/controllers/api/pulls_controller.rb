class Api::PullsController < ApplicationController
  skip_before_action :verify_authenticity_token
  def create
    # デバッグ
    Rails.logger.debug 'params'
    Rails.logger.debug params

    # レコード作成or更新
    
    redirect_to root_path
  end
end
