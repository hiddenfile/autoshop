class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :main_menu

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
  protected
  def main_menu
    @groups = Group.includes(:companies).all
    @companies = Company.includes(:groups).all
  end
end
