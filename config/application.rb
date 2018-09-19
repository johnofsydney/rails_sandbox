require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module RailsSandbox
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.

    # RSpotify.authenticate("<your_client_id>", "<your_client_secret>")
    RSpotify.authenticate("f7d2ac5775b942a99964286c4a525d0e", "b12be251ffee4013a2aadd8208322ee4")
  end
end
