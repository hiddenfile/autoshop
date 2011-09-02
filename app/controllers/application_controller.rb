class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :main_menu, :authcookie

  protected
  def main_menu
    @groups = Group.includes(:companies)
    @companies = Company.includes(:groups)
  end

  def authcookie
    @cart_count,@cart_price=CartMethods.check_or_create_cookie(cookies)
  end
end
