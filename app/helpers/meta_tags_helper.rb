# frozen_string_literal: true

module MetaTagsHelper
  # rubocop:disable Metrics/MethodLength
  def default_meta_tags
    {
      site: 'FjordChoice',
      title: 'FjordChoice',
      reverse: true,
      charset: 'utf-8',
      description: '開発チームの状況を見える化するアプリ',
      canonical: 'https://fjord-choice.herokuapp.com/',
      viewport: 'width=device-width, initial-scale=1.0',
      og: {
        site_name: :site,
        title: :title,
        description: :description,
        type: 'website',
        url: 'https://fjord-choice.herokuapp.com/',
        image: image_url('ogp.png')
      },
      twitter: {
        title: :title,
        card: 'summary_large_image',
        site: '@Saki_ht3150',
        description: :description,
        domain: 'https://fjord-choice.herokuapp.com/'
      }
    }
  end
  # rubocop:enable Metrics/MethodLength
end
