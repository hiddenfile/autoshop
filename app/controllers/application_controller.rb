class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :main_menu, :authcookie, :check_referer_link
  @current_menu_is_group=true

  protected
  def main_menu
    @groups = Group.includes(:companies)
    @companies = Company.includes(:groups)
  end

  def authcookie
    @cart_count,@cart_price=CartMethods.check_or_create_cookie(cookies)
  end

  def check_referer_link
    if request.fullpath=~/groups.\d/
      @current_menu_is_group=true
    elsif request.fullpath=~/companies.\d/
      @current_menu_is_group=false
    end
  end
end
