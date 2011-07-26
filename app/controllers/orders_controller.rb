class OrdersController < ApplicationController

  def new

  end

  def cancel
    clear_cart
    redirect_to root_path
  end

  def accept
    @order = Order.new(:user_id=>current_user.id,:order_state=>"In process")
    build_order_items(@order)

    if @order.save!
      flash[:notice]="Order was added to queue"
    else
      flash[:error] ="Error in order save process"
    end

    clear_cart
    redirect_to root_path
  end

  def show

  end

  def build_order_items(order)
#    hash = $redis.smembers(authcookie)


    items = $redis.hgetall(authcookie)
    keys = $redis.hkeys(authcookie)

    keys.each do |key|
       order.order_items.build({:product_id => key,:count => items[key].to_i()}) if items[key].to_i()>0
    end
  end

  def clear_cart()
    keys = $redis.hkeys(authcookie)

    keys.each do |key|
      $redis.hdel(authcookie,key)
    end
  end

#  def clear_cart(session_id)
#
#
#
#    keys = $redis.smembers(session_id)
#
#    keys.each do |key|
#      $redis.srem(session_id,key)
#    end
#  end
end