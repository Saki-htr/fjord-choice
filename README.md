<img width="565" alt="image" src="https://user-images.githubusercontent.com/58052292/197517347-a9c8eafe-6b32-4bc3-a234-20d2ebc2a267.png">


# サービスURL

http://fjord-choice.herokuapp.com/


# フィヨルドブートキャンプのシステム開発プラクティスに取り組んでいるチームメンバーの状況を見える化するサービスです

**Fjord Choice**は、[フィヨルドブートキャンプ](https://bootcamp.fjord.jp/welcome)というプログラミングスクールの、システム開発プラクティスに取り組んでいる受講生、メンターのkomagataさんとmachidaさんに使っていただくための、GitHubでは知ることができないチームメンバーの状況を見える化するサービスです。

## フィヨルドブートキャンプとは?
プログラマーとして就職を目指せるだけのスキルを身につけることを目標とした、オンラインプログラミングスクールです。
カリキュラムについての詳細は[こちら](https://bootcamp.fjord.jp/practices)で紹介されています。
受講生は、このカリキュラムを上から順にこなしていき、「学習の準備」〜「Webセキュリティ」まで全て完了したら、システム開発のプラクティスに取り組むことになります。

![image](https://user-images.githubusercontent.com/58052292/197517947-5ff76921-35fc-42df-97fe-509fa5fe285a.png)

([学習内容 | FJORD BOOT CAMP（フィヨルドブートキャンプ](https://bootcamp.fjord.jp/practices)）より引用)

## システム開発のプラクティスとは?

[fjordllc/bootcamp](https://github.com/fjordllc/bootcamp)リポジトリの開発をスクラムで行います。

フィヨルドブートキャンプでは、1スプリントを1週間とし、毎週水曜日に、今回のスプリントの振返りミーティングと次のスプリントの計画ミーティングを行っています。

issueには完成までにかかる時間に応じてポイントが振られることになっており、20ポイント分のPullRequestがマージされれば、このプラクティスは完了となります。
また、自分で作ったPRは、必ず同時期にシステム開発に取り組んでいる受講生の方1名とメンターのkomagataさんにレビューしていただき、2名のレビューを通ったらマージされるルールになっています。

# 使い方
システム開発のプラクティスに入った受講生の方に、「メンバー登録をする」をクリックして、メンバー登録をしていただきます。これによって、その方の情報がメンバーの表に追加される仕組みになっています。

[![Image from Gyazo](https://i.gyazo.com/36665e21844324f22996561f176b3852.gif)](https://gyazo.com/36665e21844324f22996561f176b3852)

自身に割り振られたissue20ポイント分のPullRequestがマージされたら、こちらのプラクティスは完了になるので、その際はご自身で「メンバーからはずれる」ボタンをクリックしてして退会処理をしていただきます。すると、その方の情報が表から削除されます。


メンバーへの追加と削除は、受講生の方ご自身に行っていただく必要がありますが、**このチームメンバーの表自体は、登録しなくてもどなたでも見ることができます。**


こちらは実際に使っていただいている本番環境のチームメンバーの表です。

![image](https://user-images.githubusercontent.com/58052292/202327994-0f4dc8a1-4bb9-41b3-9d5c-615ec9a769bf.png)

# 主な機能

このサービスは、以下3つの情報を得ることができます。

1. チームメンバーのアイコンまたはユーザー名をクリックすると、そのユーザーがこれまでbootcampリポジトリで作成したPullRequest一覧のGitHubリンクにアクセスできます。


[![Image from Gyazo](https://i.gyazo.com/0209d248ce4fdd463a2cdd5e27f54889.gif)](https://gyazo.com/0209d248ce4fdd463a2cdd5e27f54889)

2. ユーザー名の下にあるゲージは、これまでbootcampリポジトリでアサインされたIssueの合計ポイントです。**openかclosedか問わず、アサインされた全ての合計**が表示されます。


3. 現在チームメンバーに対してレビュー依頼されているPullRequestの数とタイトルが分かります。タイトルをクリックするとそのPullRequestのGitHubリンクにアクセスできます。

[![Image from Gyazo](https://i.gyazo.com/461a2b293e4f6bc03b09cac84a72f8cc.gif)](https://gyazo.com/461a2b293e4f6bc03b09cac84a72f8cc)


# 使用技術
- [Ruby 3.1.2](https://www.ruby-lang.org/ja/)
- [Ruby on Rails 7.0.4](https://rubyonrails.org/)
- [PostgreSQL](https://www.postgresql.org/)
- [Heroku](https://jp.heroku.com/home)
- [GitHubActions](https://docs.github.com/ja/actions)
  - (bootcampアプリに置かせてもらうワークフローファイルのリンクを貼っておく)
- [GitHub OAuth Apps](https://docs.github.com/ja/developers/apps/getting-started-with-apps/about-apps#oauth-apps-%E3%81%AB%E3%81%A4%E3%81%84%E3%81%A6)
- [BULMA](https://bulma.io/)


# 利用方法
## 環境変数の設定

|  環境変数名  |  説明  |
| ---- | ---- |
|  GITHUB_KEY  | GitHub の Client ID|
|  GITHUB_SECRET  | GitHub の Client Secret|
|FJORD_CHOICE_TOKEN| [fjordllc/bootcampリポジトリ](https://github.com/fjordllc/bootcamp)からIssue/PullRequestのデータを受信するためのトークン。こちらのwebサービスと、情報を取得したいリポジトリの両方に設定が必要です。|

## インストール
```bash
$ bin/setup
$ bin/rails server
```

## Test/Formatter & Lint

```bash
$ bundle exec rspec
$ bin/lint
```

# 参考
- 以下が、フィヨルドブートキャンプの[bootcamp](https://github.com/fjordllc/bootcamp)リポジトリに置いているGitHub Actionsのワークフローファイルです。
  - [bootcamp/post\-issue\-event\.yml at main · fjordllc/bootcamp](https://github.com/fjordllc/bootcamp/blob/main/.github/workflows/post-issue-event.yml)
  - [bootcamp/post\-pr\-event\.yml at main · fjordllc/bootcamp](https://github.com/fjordllc/bootcamp/blob/main/.github/workflows/post-pr-event.yml)
  - [bootcamp/update\_only\_when\_reviewer\_approved\.yml at main · fjordllc/bootcamp](https://github.com/fjordllc/bootcamp/blob/main/.github/workflows/update_only_when_reviewer_approved.yml)
- 以下は、開発時に検証用に使っていたリポジトリです。
  - [Saki\-htr/bootcamp\_sample: fjord\-choiceの検証用リポジトリ\(bootcampアプリのFork\)](https://github.com/Saki-htr/bootcamp_sample) 
