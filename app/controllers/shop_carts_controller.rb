class ShopCartsController < ApplicationController
  before_filter :check_cookies_valid

  def update
    if params[:id] and params[:delete_item]
      render :json => {:state => CartMethods.remove_item_from_list(cookies,params[:id])}
    elsif params[:id]
      render :json => {:state => CartMethods.add_item_to_list(cookies,params[:id],params[:order_item_attr])}
    else
      redirect_to :root
    end
  end

  def show
    @items_list = CartMethods.get_items_list(cookies)
  end

  def destroy
    CartMethods.clear_cart(cookies)
    redirect_to :root
  end

  protected

  def check_cookies_valid
    redirect_to :root if !CartMethods.cookies_valid?(cookies)
  end

end