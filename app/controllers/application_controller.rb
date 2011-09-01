class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :main_menu, :authcookie

  protected
  def main_menu
    @groups = Group.includes(:companies)
    @companies = Company.includes(:groups)
  end

  #def change_cart_cookie(new_value)
  #  cookies[:auto_shop_cart_cookie] = { :value => new_value, :expires => 1.day.from_now }
  #end
  #
  #def set_cart_cookie
  #  if current_user
  #
  #    return if (-current_user.id).to_s()==authcookie
  #    nval=(-current_user.id).to_s()
  #
  #    items = $redis.hgetall(@authcookie)
  #    keys = $redis.hkeys(@authcookie)
  #
  #    keys.each do |key|
  #      $redis.hset(nval,key,items[key])
  #      $redis.hdel(authcookie,key)
  #    end
  #
  #    change_cart_cookie(nval)
  #  else
  #    change_cart_cookie(session[:session_id])
  #  end
  #end
  #
  def authcookie
    if cookies.has_key?([:cart_id]) and cookies.has_key?(:count) and cookies.has_key?(:price)
      @cart_count=cookies[:count]
      @cart_price=cookies[:price]
    else
      cookies[:cart_id] = Digest::MD5.hexdigest("#{Time.now} + #{Array.new(4){(65+rand(26)).chr}}")
      @cart_count = @cart_price = cookies[:count] = cookies[:price] = 0
    end
  end

  def cookies_valid?(hash)
    if hash.has_key?([:cart_id])
      hash[:cart_id] =~ /^[a-f0-9]{32}$/ and hash[:count].is_a?(Integer)
    end
  end
  #
  #@count=cookies[:count]
  #    @price=cookies[:price]

  #def user_cookies
  #  cookies[:auto_shop_cart_cookie]
  #end
  #
  #def cart_menu
  #  #= { :value => new_value, :expires => 1.day.from_now }
  #end

end
