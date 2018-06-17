Rails.application.config.assets.version = '1.0'

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
Rails.application.config.assets.precompile += %w( application.js application.scss )

Rails.application.config.assets.precompile += %w(*.png *.jpg *.jpeg *.gif)
Rails.application.config.assets.precompile += %w(*.svg *.eot *.woff *.ttf)

Rails.application.config.assets.precompile << Proc.new { |path, fn| fn =~ /vendor\/assets/ && !%w(.js .css).include?(File.extname(path)) }
Rails.application.config.assets.precompile << Proc.new { |path, fn| fn =~ /vendor\/assets\/images/ }

# Rails.application.config.assets.paths << Rails.root.join("app", "assets")
