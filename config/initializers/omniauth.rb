Rails.application.config.middleware.use OmniAuth::Builder do
  # development & test 環境に対して同じclient id&secretを設定する
  if Rails.env.development? || Rails.env.test?
    provider :github, ENV['GITHUB_KEY'], ENV['GITHUB_SECRET']
  else #production環境での設定
    provider :github,
      Rails.application.credentials.github[:client_id],
      Rails.application.credentials.github[:client_secret]
  end
end