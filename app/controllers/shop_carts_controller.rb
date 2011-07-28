class ShopCartsController < ApplicationController
  def add_to_cart
    inc = params[:inc].to_i()
    count = $redis.hget(authcookie,params[:id]).to_i()

    product=Product.find(params[:id])

    if !$redis.hexists(product.id,'name')
      $redis.hset(product.id,'name',product.title)
      $redis.hset(product.id,'price',product.price==nil ? 0 : product.price.price)
    end

    count = 0 if count==nil
    if count+inc<0
      count = 0
    else
      count=count+inc
    end

    $redis.hset(authcookie,params[:id],count.to_s())
    render :template => 'shop_carts/shop_cart_info', :layout => false
  end

  def remove_from_cart
    $redis.hdel(authcookie,params[:id])
    render :template => 'shop_carts/shop_cart_info', :layout => false
  end

  def cart_items
  end
end