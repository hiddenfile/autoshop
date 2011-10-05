class AdminPanel::OrderItemsController < AdminPanel::AdminApplicationController
  before_filter :find_item, :only => [:destroy, :update]

  def create
    product = Product.find_by_id(params[:product_id])
    @item = OrderItem.where(:product_name => product.title, :order_id => params[:order_id]).first
    unless @item
      @item=OrderItem.new(:order_id=> params[:order_id],:product_name => product.title,:product_price => product.price, :count => 1)
      if @item.save
        render :json => {:state => 'add', :summary => @item.order.summary, :content => render_to_string(:partial => 'admin_panel/orders/order_item', :locals => {:order_item => @item})}
      else
        render :json => {:state => 'null'}
      end
    else
      if @item.update_attribute('count',@item.count + 1)
        render :json => ({:state => 'update', :summary => @item.order.summary, :updated_id => table_item_id(@item) ,:count => @item.count})
      else
        render :json => {:state => 'null'}
      end
    end
  end

  def destroy
    @item.recalculate_summary_on_del
    @item.delete
    render :json => {:state => true, :summary => @item.order.summary}
  end

  def update
    if @item.update_attributes(params[:order_item])
      render :json => {:state => true, :summary => @item.order.summary}
    else
      render :json => {:state => false}
    end
  end

  protected
    def find_item
      @item = OrderItem.find_by_id(params[:id])
      unless @item
        redirect_to admin_panel_orders_path, :error => "Order item is not finded"
      end
    end
end