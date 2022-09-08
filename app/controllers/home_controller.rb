# frozen_string_literal: true

class HomeController < ApplicationController
  skip_before_action :verify_authenticity_token
  require 'uri'
  require 'net/http'
  require 'json'
  require 'octokit'


  def index
    @issues = AssignedIssue.all
    @pulls = ReviewRequestedPullRequest.all
  end

  def create
    # 読み込み時に一度パースが必要
    json_request = JSON.parse(request.body.read)

    # パース後のデータを表示
    p json_request
    p params
    p params[:assignees]
    # 各要素へのアクセス方法
    # p "glossary => #{json_request["glossary"]}"
    # p "glossary.title => #{json_request["glossary"]["title"]}"

    # この後、postされたデータをDBに突っ込むなり、必要な処理を記述してください。
    # if !json_request.blank?
    #   personal = json_request
    # else
    #   personal = {'status' => 500}
    # end

    # render :json => personal
  end
end
