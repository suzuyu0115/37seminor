module ApplicationHelper
  def page_title(page_title = '')
    base_title = 'Code Hunter'

    page_title.empty? ? base_title : page_title + ' | ' + base_title
  end

  def default_meta_tags
    {
      site: 'Code Hunter',
      title: 'Code Hunter',
      reverse: true,
      charset: 'utf-8',
      description: 'Code Hunterは、ユーザーが課題の手助け(討伐)を気楽に募集、参加できる集会所(掲示板アプリ)です。',
      keywords: 'codehunter',
      canonical: request.original_url,
      separator: '|',
      # icon: [
      #   { href: image_url('favicon.ico') },
      #   { href: image_url('icon.jpg'), rel: 'apple-touch-icon', sizes: '180x180', type: 'image/jpg' },
      # ],
      og: {
        site_name: :site,
        title: :title,
        description: :description,
        type: 'website',
        url: request.original_url,
        image: image_url('logo.png'),
        locale: 'ja_JP',
      },
      twitter: {
        card: 'summary_large_image',
        site:,
      }
    }
  end
end
