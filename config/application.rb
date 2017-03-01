require_relative 'boot'

require 'rails/all'
require 'neo4j/railtie'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module WebTracking
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    config.time_zone = 'Kolkata'
    config.autoload_paths << Rails.root.join('lib')
    config.autoload_paths += Dir["#{config.root}/lib/**/"]
    config.active_record.raise_in_transactional_callbacks = true
    config.neo4j.session.type = :http
    config.neo4j.session.path = ENV['GRAPHENEDB_URL'] || 'http://localhost:7474'
  end
end
