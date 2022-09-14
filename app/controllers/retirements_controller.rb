# frozen_string_literal: true

class RetirementsController < ApplicationController
  def create
    reset_session
    # current_user.destroy!
    redirect_to root_path, notice: 'メンバーから外れました'
  end
end
