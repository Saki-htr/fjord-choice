# frozen_string_literal: true

class HomeController < ApplicationController
  def index
    @users = User.all

    # 手持ちのレビュー依頼
    pulls_uri = URI.parse('https://api.github.com/repos/fjordllc/bootcamp/pulls?per_pages=100')
    raw_pulls = Net::HTTP.get(pulls_uri)
    pulls = JSON.parse(raw_pulls, symbolize_names: true)
    pulls.delete_if do |pull| #pull[:requested_reviewers][0][:login]がnilの場合の対処
      pull[:requested_reviewers].empty? # :requested_reviewersが空の要素を削除
    end

    @results = []
    @users.each do |user|
    # userがreviewerとして登録されているPRを、userごとに抽出する
      #変数に入れることで、破壊的変更メソッドでなくてもselect後の状態を使える
      pulls_of_registered_users = pulls.select do |pull|
        pull[:requested_reviewers][0][:login] == user.name
      end
      pp pulls_of_registered_users = pulls_of_registered_users.to_json #もしかしたら .to_json しなくてもよしなにjson型にしてくれるかも?
      @results << { user: user, review_requested_pull_requests: pulls_of_registered_users }
    end
    pp @results

  end
end
