class ApplicationController < ActionController::Base
  protect_from_forgery

  layout 'application'

#  layout :layout_by_resource
#
#  def layout_by_resource
#    if devise_controller? && current_admin
#      "admin"
#    else
#      "application"
#    end
#  end
end
