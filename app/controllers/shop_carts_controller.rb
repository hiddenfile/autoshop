class ShopCartsController < ApplicationController

  def update
    if CartMethods.cookies_valid?(cookies)

      if params[:shop_cart_items]
        CartMethods.save_items_list(cookies,params[:shop_cart_items])
      elsif params[:id] and params[:delete_item]
        CartMethods.remove_item_from_list(cookies,params[:id])
      elsif params[:id]
        CartMethods.add_item_to_list(cookies,params[:id],{:title=>params[:title],:price=>params[:price].to_f, :count => 1})
      else
        redirect_to :home and return
      end
      render :text=> "true"
    else
      render :text=> params
    end
  end

  def show
    @items_list=CartMethods.get_items_list(cookies)
  end

  def destroy
    CartMethods.clear_cart(cookies)
    redirect_to root_path
  end
end