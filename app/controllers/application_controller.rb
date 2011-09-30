class ApplicationController < ActionController::Base
  protect_from_forgery
  include SimpleCaptcha::ControllerHelpers
  before_filter :main_menu, :authcookie, :check_referer_link

  @current_menu_is_group=true


  protected
  def main_menu
    @groups = Group.includes(:companies).order('name')
    @companies = Company.includes(:groups).order('name')
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
