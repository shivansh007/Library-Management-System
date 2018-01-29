# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path
# Rails.application.config.assets.paths << Emoji.images_path

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
# Rails.application.config.assets.precompile += %w( search.js )
<<<<<<< HEAD
Rails.application.config.assets.precompile += %w( library/index.js )
Rails.application.config.assets.precompile += %w( library/show.js )
Rails.application.config.assets.precompile += %w( library/index.css )
=======
Rails.application.config.assets.precompile += %w( library.js )
>>>>>>> 83c5a1387049781162ab03d3217f695c5be4743d
