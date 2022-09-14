# frozen_string_literal: true

class RetirementsController < ApplicationController
  def create
    current_user.destroy!
    reset_session
    redirect_to root_path, notice: 'メンバーから外れました'
  end
end
