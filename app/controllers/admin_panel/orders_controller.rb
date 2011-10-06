class AdminPanel::OrdersController < AdminPanel::AdminApplicationController
  before_filter :find_order, :only=>[:edit,:show]

  def index
    @orders = Order.includes(:user).all
  end

  def show
  end

  def edit
    @order_states = Order.order_states()
    @products = Product.order('title asc').all
  end

  def update
    @order = Order.find_by_id(params[:id])
    if @order.update_attributes(params[:order_attr])
      request.xhr? ? render(:text => true) : redirect_to(admin_panel_orders_path, :notice => 'Order was successfully changed.')
    else
      request.xhr? ? render(:text => false) :  redirect_to(admin_panel_orders_path, :notice => 'Update of the order is failed.')
    end
  end

  protected
    def find_order
      @order = Order.includes(:order_items).order('order_items.product_name ASC').find_by_id(params[:id])
      unless @order
        redirect_to admin_panel_orders_path
      end
    end
end