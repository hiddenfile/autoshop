require File.expand_path('../boot', __FILE__)


require 'rails/all'


Bundler.require(:default, Rails.env) if defined?(Bundler)

module Autoshop
  class Application < Rails::Application
    config.encoding = "UTF-8"
    config.filter_parameters += [:password]
    config.assets.enabled = true
    config.autoload_paths += %W( #{config.root}/app/models/ckeditor )
    config.autoload_paths << File.join(config.root, "lib")
    config.to_prepare do
      Devise::SessionsController.layout proc { |controller| resource_name == :admin ? false : 'application' }
    end
  end
end
