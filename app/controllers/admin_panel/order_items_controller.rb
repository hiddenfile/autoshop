class AdminPanel::OrderItemsController < AdminPanel::AdminApplicationController
  before_filter :find_item, :only => [:destroy, :update]

  def create
    product = Product.find_by_id(params[:product_id])
    @item=OrderItem.new(:order_id=> params[:order_id],:product_name => product.title,:product_price => product.price, :count=>1)
    render :json => {:state=>@item.save, :content=>render_to_string(:partial=>'admin_panel/orders/order_item', :locals=>{:order_item=>@item})}
  end

  def destroy
    @item.delete
    render :text => @item.destroyed?
  end

  def update
    render :text => @item.update_attribute(:count,params[:count])
  end

  protected
    def find_item
      @item = OrderItem.find_by_id(params[:id])
      unless @item
        redirect_to :back, :error => "Order item is not finded"
      end
    end
end