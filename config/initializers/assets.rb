# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path.
# Rails.application.config.assets.paths << Emoji.images_path
# Add Yarn node_modules folder to the asset load path.
Rails.application.config.assets.paths << Rails.root.join('node_modules')

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in the app/assets
# folder are already added.
# Rails.application.config.assets.precompile += %w( admin.js admin.css )
Rails.application.config.assets.precompile += %w( admin.js admin.css.scss inspinia.js )
# Be sure to restart your server when you modify this file.
Rails.application.config.assets.precompile += %w[ckeditor/config.js]


# Add additional assets to the asset load path.
# # Rails.application.config.assets.paths << Emoji.images_path
# # Add Yarn node_modules folder to the asset load path.
# Rails.application.config.assets.precompile += ['bootstrap.min.css']
# Rails.application.config.assets.precompile += %w( super_admin_dashbords.js )
# Rails.application.config.assets.precompile += %w( events.js )
# Rails.application.config.assets.precompile += %w( multi_school_group_dashbords.js )
# # Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in the app/assets
# folder are already added.
# # Rails.application.config.assets.precompile += %w( admin.js admin.css )
# Rails.application.config.assets.precompile += %w( bootstrap.min.css )
#Rails.application.config.assets.precompile += %w( custom.css )
# Rails.application.config.assets.precompile += %w( style.css )
# Rails.application.config.assets.precompile += %w( font-awesome.min.css )
# Rails.application.config.assets.precompile += %w( animate.css )
# Rails.application.config.assets.precompile += %w( font-awesome.css )
#Rails.application.config.assets.precompile += %w( grid.css )

# Rails.application.config.assets.precompile += %w( bootstrap.min.js )
# Rails.application.config.assets.precompile += %w( events.js )
# Rails.application.config.assets.precompile += %w( jquery-3.2.1.min )
# Rails.application.config.assets.precompile += %w( thumbnail-slider)
# Rails.application.config.assets.precompile += %w( presentational-only )
# Rails.application.config.assets.precompile += %w( custum )
# Rails.application.config.assets.precompile += %w( jquery-3.1.1.min )

# Rails.application.config.assets.paths << Rails.root.join("app", "assets", "fonts")