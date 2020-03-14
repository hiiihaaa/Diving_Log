require_relative 'boot'

require 'rails/all'

Bundler.require(*Rails.groups)

module DivingLog
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2
    config.time_zone = 'Tokyo'
    config.generators do |g|
      g.stylesheets false
      g.javascripts false
      g.helper      false 
    end
  end
end
