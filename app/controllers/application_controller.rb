class ApplicationController < ActionController::Base
  protect_from_forgery
  include SimpleCaptcha::ControllerHelpers
  before_filter :main_menu, :authcookie, :check_referer_link

  @current_menu_is_group = true

  protected
  def main_menu
    @groups = Group.includes(:companies).order('name')
    @companies = Company.includes(:groups).order('name')
  end

  def authcookie
    @cart_count, @cart_price = CartMethods.check_or_create_cookie(cookies)
  end

  def check_referer_link
    gr = request.fullpath =~ /groups.\d/
    comp = request.fullpath =~ /companies.\d/

    if (!gr && comp) || (gr && !comp)
      cookies[:current_menu_tab] = @current_menu_is_group = (gr != nil)
    else
      @current_menu_is_group = (cookies[:current_menu_tab] == 'true')
    end
  end
end
