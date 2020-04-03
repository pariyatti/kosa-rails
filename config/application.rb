require_relative 'boot'

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
# require "active_record/railtie"
# require "active_storage/engine"
require "action_controller/railtie"
require "action_mailer/railtie"
# require "action_mailbox/engine"
# require "action_text/engine"
require "action_view/railtie"
require "action_cable/engine"
require "sprockets/railtie"
require "rails/test_unit/railtie"
require 'neo4j/railtie'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Kosa
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.

    config.generators { |g| g.orm :neo4j }

#    cert_store = OpenSSL::X509::Store.new
#    cert_store.add_file('/the/path/to/your/neo4j.cert')
#    config.neo4j.session.options = {ssl: {cert_store: cert_store}}
#    config.neo4j.session.url = 'bolt://localhost:7474'

    # in dev, just to get things running:
    config.neo4j.session.options = {ssl: false}
  end
end
