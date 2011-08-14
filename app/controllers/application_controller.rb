class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :main_menu,:set_cart_cookie,:authcookie

  protected
  def main_menu
    @groups = Group.includes(:companies).all
    @companies = Company.includes(:groups).all
  end

  def change_cart_cookie(new_value)
    cookies[:auto_shop_cart_cookie] = { :value => new_value, :expires => 1.day.from_now }
  end

  def set_cart_cookie
    if current_user

      return if (-current_user.id).to_s()==authcookie
      nval=(-current_user.id).to_s()

      items = $redis.hgetall(@authcookie)
      keys = $redis.hkeys(@authcookie)

      keys.each do |key|
        $redis.hset(nval,key,items[key])
        $redis.hdel(authcookie,key)
      end

      change_cart_cookie(nval)
    else
      change_cart_cookie(session[:session_id])
    end
  end

  def authcookie
    @authcookie=cookies[:auto_shop_cart_cookie]
    @auth_cookie_items_count=$redis.hlen(@authcookie)
    @authcookie
  end

  def user_cookies
    cookies[:auto_shop_cart_cookie]
  end

  def cart_menu
    #= { :value => new_value, :expires => 1.day.from_now }
  end

end
