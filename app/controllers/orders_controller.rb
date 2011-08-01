class OrdersController < ApplicationController
  before_filter :authenticate_user! ,:only => :accept

  def index
    @user_orders=Order.find_all_by_user_id(current_user.id)
  end

  def show
    @order=Order.find(params[:id])
  end

  def cancel
    clear_cart
    redirect_to root_path
  end

  def remove
    @order = Order.find(params[:id])
    if @order.destroy
      flash[:notice]="Order was deleted"
    else
      flash[:error] ="Error in delete process"
    end

    redirect_to orders_path
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

  def build_order_items(order)
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
end