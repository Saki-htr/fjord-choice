# Fjord Choice

(OGP画像)

## サービスURL

http://fjord-choice.herokuapp.com/


## フィヨルドブートキャンプのチーム開発の状況を見える化するアプリです

**Fjord Choice**は、[フィヨルドブートキャンプ](https://bootcamp.fjord.jp/welcome)というプログラミングスクールの、システム開発のカリキュラムに取り組んでいる受講生向けの、GitHubでは知ることができないチーム開発の状況を見える化するサービスです。
オンラインのスクールで、

### フィヨルドブートキャンプとは?
プログラマーとして就職を目指せるだけのスキルを身につけることを目標とした、オンラインプログラミングスクールです。
カリキュラムについての詳細は[こちら](https://bootcamp.fjord.jp/practices)で紹介されています。
受講生は、このカリキュラムを上から順にこなしていき、「学習の準備」〜「Webセキュリティ」まで全て完了したら、システム開発のプラクティスに取り組むことになります。

(プラクティス画像の引用)

### システム開発のカリキュラムとは?

[fjordllc/bootcamp](https://github.com/fjordllc/bootcamp)リポジトリの開発をスクラムで行います。

フィヨルドブートキャンプでは、1スプリントを1週間とし、毎週水曜日に、今回のスプリントの振返りミーティングと次のスプリントの計画ミーティングを行っています。

issueには完成までにかかる時間に応じてポイントが振られることになっており、20ポイント分のPull Request(以降、PRと記載)がマージされれば、このカリキュラムは完了となります。
また、自分で作ったPRは、必ず同時期にシステム開発に取り組んでいるFBC受講生の方1名とメンターのkomagataさんにレビューしていただき、2名のレビューを通ったらマージされるルールになっています。

## 使い方
システム開発プラクティスに取り組む受講生に、「メンバーに自分を追加する」をクリックしてGitHubアカウントでログインしていただきます。すると、そのユーザーの情報が表に追加されます。
システム開発を終了したら、「メンバーからはずれる」をクリックしていただきます。すると、退会処理が行われ、そのユーザーの情報が表から削除されます。

(スクリーンショット)

## どんな情報が得られるのか?
以下3つの情報を得ることができます。

1. 登録されているアイコンまたはユーザー名をクリックすると、そのユーザーがこれまでbootcampリポジトリで作成したPull Requestの一覧が分かるGitHubリンク
2. これまでアサインされたIssueの合計ポイント
3. 現在レビュー依頼されているPull Request

## 使用技術
- [Ruby 3.1.2](https://www.ruby-lang.org/ja/)
- [Ruby on Rails 7.0.4](https://rubyonrails.org/)
- [PostgreSQL](https://www.postgresql.org/)
- [Heroku](https://jp.heroku.com/home)
- [GitHubActions](https://docs.github.com/ja/actions)
  - (bootcampアプリに置かせてもらうワークフローファイルのリンクを貼っておく)
- [GitHub OAuth Apps](https://docs.github.com/ja/developers/apps/getting-started-with-apps/about-apps#oauth-apps-%E3%81%AB%E3%81%A4%E3%81%84%E3%81%A6)
- [BULMA](https://bulma.io/)


## 利用方法
### 環境変数の設定

|  環境変数名  |  説明  |
| ---- | ---- |
|  GITHUB_KEY  | GitHub の Client ID|
|  GITHUB_SECRET  | GitHub の Client Secret|
|FJORD_CHOICE_TOKEN| [fjordllc/bootcampリポジトリ](https://github.com/fjordllc/bootcamp)からIssue/Pull Requestのデータを受信するためのトークン|

### インストール
```bash
$ bin/setup
$ bin/rails server
```

### Test/Formatter & Lint

```bash
$ bundle exec rspec
$ bin/lint
```




