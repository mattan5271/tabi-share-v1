require_relative 'boot'

require 'rails/all'
require 'csv' # CSV入出力

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module TaBiShare
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2
    config.i18n.default_locale = :ja # 日本語に変換
    config.time_zone = 'Tokyo' # 日本時間に変換
    config.generators.template_engine = :slim # テンプレートエンジンをslimに変更
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
  end
end
