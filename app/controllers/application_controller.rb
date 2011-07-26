class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :main_menu,:cart_items_names

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

  def cart_items_names
    keys = $redis.hkeys(session[:session_id])

    @products_names=[]

    keys.each do |key|
      @products_names<<Product.find(key).title
    end
  end
end
