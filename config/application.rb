require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module RailsTemplate
  class Application < Rails::Application
    config.load_defaults 5.1

    config.active_job.queue_adapter = :shoryuken

    config.autoload_paths << Rails.root.join('app/events')
    config.autoload_paths << Rails.root.join('app/forms')

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    config.generators do |g|
      g.fixture_replacement :factory_bot, dir: 'spec/factories'
      g.integration_tool :rspec
      g.test_framework :rspec
    end
  end
end
