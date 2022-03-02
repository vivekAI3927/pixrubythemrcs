require_relative 'boot'

require 'rails/all'

require 'pdfkit'

require 'csv'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module PassTheMrcs
  class Application < Rails::Application
  	config.middleware.use PDFKit::Middleware, :print_media_type => true 
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0
    config.exceptions_app = self.routes

		config.i18n.default_locale = :en
    # config.time_zone = 'London'
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
  end
end
