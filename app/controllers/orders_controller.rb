class OrdersController < ApplicationController
  before_filter :authenticate_user!
  before_filter :find_order , :only => [:show, :destroy]

  def index
    @user_orders=current_user.orders.order("created_at  DESC")
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

    if @order.save!
      flash[:notice]="Order was added to queue"
    else
      flash[:error] ="Error in order save process"
    end

    CartMethods.clear_cart(cookies)
    redirect_to orders_path
  end

  private
  def build_order_items(order)
    items = CartMethods.get_items_list(cookies)

    items.each do |key,item|
      order.order_items.build({:count => item['count'],:product_name=>item['title'],:product_price=>item['price'],:product_discount => current_user.discount.try(:value) })
    end
  end

  def find_order
    unless @order=Order.includes(:order_items).find_by_id(params[:id])
      flash[:error] = "Could not find id: #{params[:id]}"
      redirect_to root_path
    end
  end
end