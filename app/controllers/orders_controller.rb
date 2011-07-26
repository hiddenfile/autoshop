class OrdersController < ApplicationController

  def new

  end

  def cancel
    clear_cart(session[:session_id])
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

    clear_cart(session[:session_id])
    redirect_to root_path
  end

  def show

  end

  def build_order_items(order)
    items = $redis.hgetall(session[:session_id])
    keys = $redis.hkeys(session[:session_id])

    keys.each do |key|
       order.order_items.build({:product_id => key,:count => items[key].to_i()}) if items[key].to_i()>0
    end
  end

  def clear_cart(session_id)
    keys = $redis.hkeys(session_id)

    keys.each do |key|
      $redis.hdel(session_id,key)
    end
  end
end