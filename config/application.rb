require_relative "boot"

require "rails/all"
require 'dotenv'
Dotenv.load

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module App
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")

    config.generators do |g|
      g.skip_routes true   # ルーティングを生成しない
      g.assets false       # assetsファイルを生成しない
      g.helper false       # helperを生成しない
      g.test_framework false  # testファイルを生成しない
    end

    # デフォルトのlocaleを日本語(:ja)に変更
    config.i18n.default_locale = :ja
    config.i18n.load_path += Dir[Rails.root.join('config/locales/**/*.{rb,yml}').to_s]

    # タイムゾーンを東京に設定
    config.time_zone = "Tokyo"
    config.active_record.default_timezone = :local
  end
end
