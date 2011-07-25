class OrdersController < ApplicationController

  def new

  end

  def cancel
    $redis.hdel(session[:session_id])
    redirect_to root_path
  end

  def accept
    @order = Order.new(current_user.id,"In process")
    build_order_items(@order)

    if @order.save!
      flash[:notice]="Order was added to queue"
    else
      flash[:error] ="Error in order save process"
    end

    $redis.hdel(session[:session_id])
    redirect_to root_path
  end

  def show

  end

  def build_order_items(order)
    items = $redis.hgetall(session[:session_id])
    keys = $redis.hkeys(session[:session_id])

    keys.each do |key|
       order.order_items.build({:product_id => key,:count => items[key].to_i()}) if items[key]>0
    end
  end
end