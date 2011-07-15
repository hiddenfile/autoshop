require File.expand_path('../boot', __FILE__)

require 'rails/all'

Bundler.require(:default, Rails.env) if defined?(Bundler)

module Avtoportal
  class Application < Rails::Application
    config.encoding = "utf-8"
    config.filter_parameters += [:password]
    config.assets.enabled = true
  end
end

#module Paperclip
#  module Interpolations
#    def rails_root attachment, style
#      Rails.root
#    end
#  end
#end