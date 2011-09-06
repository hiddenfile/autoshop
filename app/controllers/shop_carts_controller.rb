class ShopCartsController < ApplicationController
  before_filter :check_cookies_valid

  def update
    if params[:id] and params[:delete_item]
      CartMethods.remove_item_from_list(cookies,params[:id])
    elsif params[:id]
      CartMethods.add_item_to_list(cookies,params[:id],{:title=>params[:title],:price=>params[:price].to_f, :count => 1})
    else
      redirect_to :home and return
    end
    render :text=> "true"
  end

  def show
    @items_list=CartMethods.get_items_list(cookies)
  end

  def destroy
    CartMethods.clear_cart(cookies)
    redirect_to root_path
  end

  protected

  def check_cookies_valid
    redirect_to root_path if !CartMethods.cookies_valid?(cookies)
  end

end