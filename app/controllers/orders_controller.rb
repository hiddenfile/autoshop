class OrdersController < ApplicationController
  before_filter :authenticate_user!
  #before_filter :find_order , :only => [:show, :destroy]

  def index
    @user_orders=current_user.orders
  end

  def show
  end

  def destroy
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

    if @order.save
      flash[:notice]="Order was added to queue"
    else
      flash[:error] ="Error in order save process"
    end

    RedisMethods.clear_cart(authcookie)
    redirect_to orders_path
  end

  private
  def build_order_items(order)
    items = $redis.hgetall(authcookie)
    keys = $redis.hkeys(authcookie)

    keys.each do |key|
       curr_product=Product.find_by_id(key)
       order.order_items.build({:count => items[key].to_i(),:product_name=>curr_product.title,:product_price=>curr_product.price,:product_discount => current_user.discount.try(:value) }) if curr_product
    end
  end

  def find_order
    unless @order = Order.find_by_id(params[:id])
      flash[:error] = "Could not find id: #{params[:id]}"
      redirect_to root_path
    end
  end
end