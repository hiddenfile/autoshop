class OrdersController < ApplicationController
  before_filter :authenticate_user!

  def index
    @user_orders=current_user.orders
  end

  def show
    find_order()
  end

  def destroy
    find_order()
    if @order.destroy
      flash[:notice]="Order was deleted"
    else
      flash[:error] ="Error in delete process"
    end

    redirect_to orders_path
  end

  def create
    @order = Order.new(:user_id=>current_user.id,:order_state=>"In process")
    build_order_items(@order)

    if @order.save!
      flash[:notice]="Order was added to queue"
    else
      flash[:error] ="Error in order save process"
    end

    RedisMethods.clear_cart(authcookie)
    redirect_to orders_path
  end

  def build_order_items(order)
    items = $redis.hgetall(authcookie)
    keys = $redis.hkeys(authcookie)

    keys.each do |key|
       order.order_items.build({:product_id => key,:count => items[key].to_i()}) if items[key].to_i()>0
    end
  end

  def find_order
    unless @order = Order.find_by_id(params[:id])
      flash[:error] = "Could not find id: #{params[:id]}"
      redirect_to root_path
    end
  end
end